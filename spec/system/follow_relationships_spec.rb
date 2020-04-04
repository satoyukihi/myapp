require 'rails_helper'

RSpec.describe 'FollowRelationships', type: :system do
  let(:user) { FactoryBot.create(:user, admin: true) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:follow_relationship) do
    FactoryBot.create(:follow_relationship,
                      following_id: other_user.id, follower_id: user.id)
  end

  #   it 'ユーザーが他のユーザーをフォロー実行、解除できる', js: true do
  #        user
  #        other_user
  #        visit login_path
  #        fill_in 'session[email]',    with: user.email
  #        fill_in 'session[password]', with: user.password
  #        click_button 'ログイン'
  #
  #        expect do
  #          find('/follow_relationships').click
  #          sleep 0.5
  #        end.to change(user.followings, :count).by(1)
  #
  #        expect do
  #          find('/follow_relationships/').click
  #          sleep 0.5
  #        end.to change(user.followings, :count).by(-1)
  #    end

  it 'ユーザーが削除されると関連するフォローも削除されること' do
    sign_in_as user
    follow_relationship
    visit root_url
    expect do
      visit user_path(other_user)
      click_link 'ユーザー削除'
    end.to change(user.followings, :count).by(-1)
  end
end
