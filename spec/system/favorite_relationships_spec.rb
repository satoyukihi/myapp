require 'rails_helper'

RSpec.describe 'FavoriteRelationships', type: :system do
  let(:user) { FactoryBot.create(:user, admin: true) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost, user_id: other_user.id) }
  let(:iine) do
    FactoryBot.create(:favorite_relationship,
                      user_id: user.id,
                      micropost_id: micropost.id)
  end

  it 'ユーザーがマイクロポストいいね実行、解除できる', js: true do
    micropost

    visit login_path
    fill_in 'session[email]',    with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'ログイン'

    expect do
      find('.new_favorite_relationship').click
      sleep 0.5
    end.to change(user.likes, :count).by(1)

    expect do
      find('.edit_favorite_relationship').click
      sleep 0.5
    end.to change(user.likes, :count).by(-1)
  end

  it 'ユーザーが削除されると関連するいいねも削除されること' do
    sign_in_as user
    iine
    visit root_url
    expect  do
        visit user_path(other_user)
        click_link 'ユーザー削除'
    end.to change(user.likes, :count).by(-1)
  end
end
