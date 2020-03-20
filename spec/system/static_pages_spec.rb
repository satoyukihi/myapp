require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost) }
  let(:comment) { FactoryBot.create(:comment) }
  let(:other_comment) { FactoryBot.create(:comment) }
  let(:tag) { FactoryBot.create(:tag) }
  let(:other_tag) { FactoryBot.create(:tag) }

  describe 'トップページ' do
    context 'ページレイアウト' do
      before do
        visit root_path
      end

      it '「ようこそMyごはんへ」の文字列が存在すること' do
        expect(page).to have_content 'ようこそMyごはんへ'
      end

      it 'ログイン済みユーザーは「ようこそMyごはんへ」の文字列が存在しないこと' do
        sign_in_as user
        expect(page).to_not have_content 'ようこそMyごはんへ'
      end

      it '正しいページタイトルが表示されること' do
        expect(page).to have_title 'Myごはん'
      end

=begin  context '検索機能' do
        it 'タイトルで検索できること' do
          micropost
          fill_in 'search', with: micropost.title.to_s
          click_button '検索'
          expect(page).to have_content micropost.title.to_s
        end

        it 'タイトルで検索できること（条件に合わないものは表示されないこと）' do
          micropost
          fill_in 'search', with: 'aiueo'
          click_button '検索'
          expect(page).to_not have_content micropost.title.to_s
        end

        it 'マイクロポストの内容で検索できること' do
          micropost
          fill_in 'search', with: micropost.content.to_s
          click_button '検索'
          expect(page).to have_content micropost.title.to_s
        end

        it 'マイクロポストの内容で検索できること（条件に合わないものは表示されないこと）' do
          micropost
          fill_in 'search', with: 'aiueo'
          click_button '検索'
          expect(page).to_not have_content micropost.title.to_s
        end

        it 'マイクロポスト内のコメントが検索できること' do
          comment
          fill_in 'search', with: comment.content.to_s
          click_button '検索'
          expect(page).to have_content comment.micropost.title.to_s
        end

        it 'マイクロポスト内のコメントが検索できること（条件に合わないものは表示されないこと）' do
          comment
          fill_in 'search', with: 'aiueo'
          click_button '検索'
          expect(page).to_not have_content comment.micropost.title.to_s
        end
      end
=end

      context 'タグ検索' do
        before do
          tag
          other_tag
          visit root_path
        end
        it 'タグ検索できること' ,js: true do
         select tag.name, from: 'tag_id'
         expect(page).to have_content "test1" 
        end
        
        it 'タグ検索できること（条件に合わないものは表示されないこと）', js: true do
          select tag.name, from: 'tag_id'
          expect(page).to_not have_content "test1" 
        end
      end
    end
  end
end
