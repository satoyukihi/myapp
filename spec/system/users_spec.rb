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
      
      it '正しいページタイトルが表示されること' do
        expect(page).to have_title 'Myごはん - 新規登録'
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
          fill_in 'user[password]', with: 'foobar'
          fill_in 'user[password_confirmation]', with: 'foobar'
          click_button '作成'

          expect(page).to have_content 'ユーザー登録完了！Myごはんへようこそ！！'
        end.to change(User, :count).by(1)
      end
    end
    context 'ユーザー情報編集' do
      it 'ユーザー自身がユーザー情報を編集する' do
        sign_in_as user
        click_link "ようこそ#{user.name}さん‼"
        click_link '編集ページへ'
        fill_in 'user[name]', with: 'yuki'
        fill_in 'user[email]', with: 'test@example.com'
        click_button '編集'

        expect(page).to have_content 'ユーザー情報を編集しました‼'
        expect(page).to have_content 'yuki'
      end

      it '他のユーザーページで編集が表示されないこと' do
        user
        sign_in_as(other_user)
        visit user_path(user)
        expect(page).to_not have_content '編集'
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
        user
        sign_in_as(user)
        expect do
          visit user_path(user)
          click_link 'ユーザー削除'
          expect(page).to have_content 'ユーザーを削除しました'
        end.to change(User, :count).by(-1)
      end

      it '他のユーザーページで削除が表示されないこと' do
        user
        sign_in_as(other_user)
        visit user_path(user)
        expect(page).to_not have_content 'ユーザー削除'
      end
    end
    context 'ユーザー詳細' do
      it 'ゲストユーザーで他のユーザーの詳細ページに行く' do
        user
        visit user_path(user)
        expect(page).to_not have_content '#{user.name}'
      end
    end
  end
end

#   describe "マイクロポストの表示（検索、ページネーション）" do
#
#     it "マイクロポストのタイトル検索、ページネーションが機能していること" do
#       micropost8
#       visit root_path
#       expect(page).to have_content "件の投稿が表示されています"
#       expect(page).to have_link "次"
#
#       expect(page).to_not have_content "test1"
#       fill_in "q_title_cont", with: "test1"
#       click_button "検索"
#       expect(page).to have_content "test1"
#
#       sign_in_as(user)
#       visit user_path(user)
#       expect(page).to have_content "件の投稿が表示されています"
#       expect(page).to have_link "次"
#     end
#   end
