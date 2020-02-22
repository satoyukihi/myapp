require 'rails_helper'

RSpec.feature "Microposts", type: :feature do
  scenario "ユーザーは新しいマイクロポストを作成する" do
      user = FactoryBot.create(:user)
      
      
      sign_in_as user
      
      expect{
          click_link "新規投稿"
          fill_in "micropost[title]", with: "Test Micropost"
          fill_in "micropost[content]", with: "Test content"
          attach_file "micropost[picture]", "#{Rails.root}/spec/fixtures/test.jpg"
          click_button "投稿！"
        }.to change(user.microposts, :count).by(1)
          
        aggregate_failures do
          expect(page).to have_content "投稿しました!"
          expect(page).to have_content "Test content"
          expect(page).to have_content "#{user.name}"
        end
      
  end
end
