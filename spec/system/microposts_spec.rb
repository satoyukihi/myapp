require 'rails_helper'

RSpec.describe 'Microposts', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost, user_id: user.id) }

  describe 'マイクロポスト作成ページ' do
    context 'ページレイアウト' do
      it '新規投稿の文字列が存在すること' do
        sign_in_as user
        visit new_micropost_path
        expect(page).to have_content '新規投稿'
      end
    end

    context 'マイクロポスト作成' do
      before do
        sign_in_as user
        visit new_micropost_path
      end

      it 'ユーザーは新しいマイクロポストを作成する' do
        expect do
          fill_in 'micropost[title]', with: 'Test Micropost'
          fill_in 'micropost[content]', with: 'Test content'
          attach_file 'micropost[picture]', "#{Rails.root}/spec/fixtures/test.jpg"
          click_button '投稿！'
        end.to change(user.microposts, :count).by(1)

        aggregate_failures do
          expect(page).to have_content '投稿しました!'
          expect(page).to have_content 'Test content'
          expect(page).to have_content user.name.to_s
        end
      end

      it 'タグを付けてマイクロポストを作成できること' do
        expect do
          fill_in 'micropost[title]', with: 'Test Micropost'
          fill_in 'micropost[content]', with: 'Test content'
          attach_file 'micropost[picture]', "#{Rails.root}/spec/fixtures/test.jpg"
          fill_in 'micropost[tag_ids]', with: 'test,test2'
          click_button '投稿！'
          expect(page).to have_content '投稿しました!'
          expect(page).to have_content 'test test2'
        end.to change(user.microposts, :count).by(1)
      end

      it '無効な値でマイクロポストを作成できないこと' do
        expect do
          fill_in 'micropost[title]', with: 'Test Micropost'
          fill_in 'micropost[content]', with: ''
          attach_file 'micropost[picture]', "#{Rails.root}/spec/fixtures/test.jpg"
          click_button '投稿！'
          expect(page).to have_content '個のエラー'
        end.to_not change(user.microposts, :count)
      end
    end
  end

  describe 'マイクロポスト削除' do
    before do
      micropost
    end

    it 'ユーザーは自身のマイクロポストを削除する' do
      sign_in_as user
      expect  do
        visit root_path
        click_link '削除'
      end.to change(user.microposts, :count).by(-1)
    end

    it '他ユーザーのマイクロポスト削除リンクが表示されないこと' do
      sign_in_as other_user
      visit root_path
      expect(page).to_not have_content '削除'
    end

    it 'ユーザーを削除すると関連するマイクロポストも削除される' do
      sign_in_as user
      visit root_url
      expect do
        visit user_path(user)
        click_link 'ユーザー削除'
      end.to change(Micropost, :count).by(-1)
    end
  end

  describe 'マイクロポスト編集' do
    context 'ページレイアウト' do
      before do
        micropost
      end
      it '投稿編集の文字列が存在すること' do
        sign_in_as user
        visit edit_micropost_path(micropost)
        expect(page).to have_content '投稿編集'
      end

      it '他ユーザーの投稿で編集の文字列が存在しないこと' do
        sign_in_as other_user
        expect(page).to_not have_content '投稿編集'
      end
    end

    context '投稿編集機能' do
      before do
        micropost
        sign_in_as user
        visit edit_micropost_path(micropost)
      end

      it '有効な情報で編集できること' do
        fill_in 'micropost[title]', with: 'Test2 Micropost'
        fill_in 'micropost[content]', with: 'Test2 content'
        click_button '編集'
        expect(page).to have_content '投稿を編集しました'
        expect(page).to have_content 'Test2 Micropost'
      end

      it '無効な情報で編集できないこと' do
        fill_in 'micropost[title]', with: ''
        fill_in 'micropost[content]', with: ''
        click_button '編集'
        expect(page).to have_content '個のエラー'
      end

      it 'タグを編集できること' do
        fill_in 'micropost[title]', with: 'Test Micropost'
        fill_in 'micropost[content]', with: 'Test content'
        fill_in 'micropost[tag_ids]', with: 'test12'
        click_button '編集'
        expect(page).to have_content '投稿を編集しました'
        expect(page).to have_content 'test12'
      end
    end
  end
end
