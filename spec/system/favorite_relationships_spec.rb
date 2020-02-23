require 'rails_helper'

RSpec.describe "FavoriteRelationships", type: :system do
  let(:user)      {FactoryBot.create(:user, admin: true)}
  let(:other_user){FactoryBot.create(:user)}
  let(:micropost) {FactoryBot.create(:micropost, user_id: other_user.id)}
  let(:iine)        {FactoryBot.create(:favorite_relationship,
                                          user_id:  user.id, 
                                     micropost_id:  micropost.id )}

  it "ユーザーがマイクロポストいいね実行、解除できる", js: true do
    micropost
     
     visit login_path
      #click_link "Myごはんを始める"
      fill_in "session[email]",    with: user.email
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
    
  it "ユーザーが削除されると関連するいいねも削除されること" do
    sign_in_as user
    iine
    expect{
        visit root_url
        expect(page).to have_content "1件の投稿が表示されています"
      
        expect{
          visit user_path(other_user)
          click_link "ユーザー削除"
        }.to change(User, :count).by(-1)
      }.to change(user.likes, :count).by(-1)
  end
 end