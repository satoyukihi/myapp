require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user)       { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:user_admin) { FactoryBot.create(:user, admin: true) }
  let(:micropost)  { FactoryBot.create(:micropost) }
  let(:micropost8) { FactoryBot.create_list(:micropost, 8, user_id: user.id) }

  describe 'ユーザー登録ページ' do
    context 'ページレイアウト' do
      before do
        visit root_path
      end

      it 'ユーザー登録の文字列が存在すること' do
        expect(page).to have_content 'ユーザー登録'
      end
    end

    context 'ユーザー登録処理' do
      before do
        visit signup_path
      end
      it 'ユーザー登録ができること' do
        expect do
          click_link '新規ユーザー登録'
          fill_in 'user[name]', with: 'yuki'
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'foobar12A'
          fill_in 'user[password_confirmation]', with: 'foobar12A'
          click_button '作成'

          expect(page).to have_content 'ユーザー登録完了！Myごはんへようこそ！！'
        end.to change(User, :count).by(1)
      end
      it '無効な値でユーザー登録ができないこと' do
        expect do
          click_link '新規ユーザー登録'
          fill_in 'user[name]', with: 'yuki'
          fill_in 'user[email]', with: 'test@example.com'
          fill_in 'user[password]', with: 'foobar'
          fill_in 'user[password_confirmation]', with: 'barfoo'
          click_button '作成'

          expect(page).to have_content '個のエラー'
        end.to_not change(User, :count)
      end
    end
  end

  describe 'ユーザーページ' do
    before do
      sign_in_as user
      visit user_path(user)
    end

    context 'ページレイアウト' do
      it 'ユーザー情報の文字列が存在すること' do
        expect(page).to have_content 'ユーザー情報'
      end
    end

    context 'ユーザー情報編集' do
      it 'ユーザー自身がユーザー情報を編集する' do
        click_link '編集ページへ'
        fill_in 'user[name]', with: 'yuki'
        fill_in 'user[email]', with: 'test@example.com'
        click_button '編集'

        expect(page).to have_content 'ユーザー情報を編集しました‼'
        expect(page).to have_content 'yuki'
      end

      it '他のユーザーページで編集が表示されないこと' do
        other_user
        visit user_path(other_user)
        expect(page).to_not have_content '編集'
      end

      it '他のユーザーページで編集が表示されないこと(ゲストユーザー)' do
        click_link 'ログアウト'
        visit user_path(user)
        expect(page).to_not have_content '編集'
      end
    end
  end

  context 'ユーザー削除' do
    it '管理者としてユーザーを削除する' do
      user
      sign_in_as(user_admin)
      expect  do
        visit user_path(user)
        click_link 'ユーザー削除'
        expect(page).to have_content 'ユーザーを削除しました'
      end.to change(User, :count).by(-1)
    end

    it 'ユーザーが自身を削除する' do
      sign_in_as(user)
      expect do
        visit user_path(user)
        click_link 'ユーザー削除'
        expect(page).to have_content 'ユーザーを削除しました'
      end.to change(User, :count).by(-1)
    end

    it '他のユーザーページで削除が表示されないこと' do
      sign_in_as(other_user)
      visit user_path(user)
      expect(page).to_not have_content 'ユーザー削除'
    end

    it '他のユーザーページで削除が表示されないこと(ゲストユーザー)' do
      visit user_path(user)
      expect(page).to_not have_content 'ユーザー削除'
    end
  end
end
