require 'rails_helper'

RSpec.feature "Microposts", type: :feature do
  scenario "ユーザーは新しいマイクロポストを作成する" do
      user = FactoryBot.create(:user)
      
      
      visit root_path
      click_link "ログイン"
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "ログイン"
      
      expect{
          click_link "新規投稿"
          fill_in "micropost[title]", with: "Test Micropost"
          fill_in "micropost[content]", with: "Test content"
          attach_file "micropost[picture]", "#{Rails.root}/spec/fixtures/test.jpg"
          click_button "投稿！"
          
          
          expect(page).to have_content "投稿しました!"
          expect(page).to have_content "Test Micropost"
          expect(page).to have_content "#{user.name}"
        
      }.to change(user.microposts, :count).by(1)
      
  end
end
