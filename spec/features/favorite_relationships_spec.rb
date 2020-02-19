require 'rails_helper'

RSpec.feature "FavoriteRelationships", type: :feature do
  
  scenario "ユーザーがマイクロポストにいいねする", js: true do
     micropost  = FactoryBot.create(:micropost)
     
     visit root_path
      click_link "ログイン"
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "ログイン"
      
      expect{
      click_button "like"
      }.to change(user.likes, :count).by(1)
  end
end
