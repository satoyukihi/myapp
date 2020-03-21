require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost) }
  let(:other_micropost) { FactoryBot.create(:micropost) }
  let(:comment) { FactoryBot.create(:comment) }

  context 'コメント作成' do
    before do
      micropost
    end

    it 'ゲストユーザーはコメントできないこと' do
      visit "/microposts/#{micropost.id}"
      expect do
        fill_in 'comment[content]', with: 'コメンと'
        click_button 'コメントする'
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end.to_not change(Comment, :count)
    end

    it '無効な値でコメントできないこと' do
      sign_in_as user
      expect do
        visit "/microposts/#{micropost.id}"
        fill_in 'comment[content]', with: ''
        click_button 'コメントする'
      end.to_not change(Comment, :count)
    end

    it 'ログインしているユーザーはコメントできること' do
      sign_in_as user
      visit "/microposts/#{micropost.id}"
      expect do
        fill_in 'comment[content]', with: 'なんでも'
        click_button 'コメントする'
        expect(page).to have_content 'コメントしました'
      end.to change(Comment, :count).by(1)
    end

    it 'コメントが他のページで表示されていないこと' do
      other_micropost
      sign_in_as user
      visit "/microposts/#{micropost.id}"
      fill_in 'comment[content]', with: '他のページで表示されない'
      click_button 'コメントする'

      visit "/microposts/#{other_micropost.id}"
      expect(page).to_not have_content '他のページで表示されない'
    end
  end

  context 'コメントの削除' do
    before do
      comment
      visit "/microposts/#{comment.micropost.id}"
    end

    it 'ゲストユーザーはコメントを削除できないこと' do
      expect(page).to_not have_content '削除'
    end

    it '自分のコメント以外は削除できないこと' do
      sign_in_as other_user
      visit "/microposts/#{comment.micropost.id}"
      expect(page).to_not have_content '削除'
    end

    it '有効なユーザーはコメントを削除できること' do
      sign_in_as comment.user
      visit "/microposts/#{comment.micropost.id}"
      expect do
        click_link 'commentdelete'
      end.to change(Comment, :count).by(-1)
    end
  end

  it 'ユーザーを削除すると関連するコメントも削除される'
  it 'マイクロポストを消すと関連するコメントも削除される'
end
