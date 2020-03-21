require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    visit root_path
  end
  describe 'ログインページ' do
    context 'ページレイアウト' do
      it '「ログイン」の文字列が存在すること' do
        expect(page).to have_content 'ログイン'
      end
    end

    context 'ログイン機能' do
      it 'ログインできること' do
        user
        visit root_path
        click_link 'ログイン'
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログイン成功‼'
      end

      it 'ログアウトできること' do
        sign_in_as(user)
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
