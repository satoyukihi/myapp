require 'rails_helper'

RSpec.describe 'Notifications', type: :system do
  let(:user)       { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:other_user2) { FactoryBot.create(:user) }
  let(:micropost)  { FactoryBot.create(:micropost, user: other_user) }
  let(:comment)    { FactoryBot.create(:comment, user: other_user2, micropost: micropost) }
  let(:notification) { FactoryBot.create(:notification, :like, visitor: user, visited: other_user) }
  let(:notification2) do
    FactoryBot.create(:notification, :like,
                      visited: other_user, visitor: user, micropost: micropost)
  end
  let(:notification3) do
    FactoryBot.create(:notification, :comment,
                      visited: other_user2, visitor: other_user, comment: comment)
  end
  let(:notification4) { FactoryBot.create(:notification, :like, visitor: other_user, visited: user) }

  describe '通知ページ' do
    context 'ページレイアウト' do
      it '通知の文字列が存在すること' do
        sign_in_as user
        visit notifications_path
        expect(page).to have_content '通知'
      end
    end

    context '通知機能' do
      before do
        sign_in_as user
        micropost
      end

      it 'いいねした時に通知が作成されること' do
        expect do
          visit micropost_path(micropost)
          find('.iine').click
        end.to change(user.likes, :count).by(1)
      end

      it 'フォローした時に通知が作成されること' do
        expect do
          visit user_path(other_user)
          click_button 'フォロー'
        end.to change(user.active_notifications, :count).by(1)
      end

      it 'コメントした時に通知が作成されること' do
        expect do
          visit "/microposts/#{micropost.id}"
          fill_in 'comment[content]', with: 'なんでも'
          click_button 'コメントする'
          expect(page).to have_content 'コメントしました'
        end.to change(user.active_notifications, :count).by(1)
      end

      it 'コメントしている人にも通知が作成されること' do
        comment
        expect do
          visit "/microposts/#{micropost.id}"
          fill_in 'comment[content]', with: 'なんでも'
          click_button 'コメントする'
          expect(page).to have_content 'コメントしました'
        end.to change(other_user2.passive_notifications, :count).by(1)
      end

      it 'ユーザーが削除された際に通知も削除されること' do
        notification
        expect do
          visit user_path(user)
          click_link 'ユーザー削除'
        end.to change(other_user.passive_notifications, :count).by(-1)
      end

      it 'マイクロポストが削除された際に通知も削除されること' do
        notification2
        click_link 'ログアウト'
        sign_in_as other_user
        expect do
          visit "/microposts/#{micropost.id}"
          click_link '削除'
        end.to change(other_user.passive_notifications, :count).by(-1)
      end

      it 'コメントが削除された際に通知も削除されること' do
        notification3
        click_link 'ログアウト'
        sign_in_as other_user2
        expect do
          visit "/microposts/#{micropost.id}"
          click_link 'commentdelete'
        end.to change(other_user2.passive_notifications, :count).by(-1)
      end

      it '通知を削除できること' do
        notification4
        expect do
          visit notifications_path
          click_link '通知削除'
        end.to change(user.passive_notifications, :count).by(-1)
      end
    end
  end
end
