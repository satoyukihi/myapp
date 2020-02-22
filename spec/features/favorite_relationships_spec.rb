require 'rails_helper'

RSpec.feature "FavoriteRelationships", type: :feature do

  scenario "ユーザーがマイクロポストにいいねするして解除", js: true do
    user = FactoryBot.create(:user)
    micropost  = FactoryBot.create(:micropost)
     
     visit login_path
      #click_link "Myごはんを始める"
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      click_button "ログイン"
      
      expect{
      find('.new_favorite_relationship').click
      sleep 0.5
      }.to change(user.likes, :count).by(1)
      
      expect{
      find('.edit_favorite_relationship').click
      sleep 0.5
      }.to change(user.likes, :count).by(-1)
    end
 end