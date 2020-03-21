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
 end
end
