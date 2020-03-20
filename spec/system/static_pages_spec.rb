require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  let(:micropost) { FactoryBot.create(:micropost) }
  let(:comment) { FactoryBot.create(:comment) }
  let(:other_comment) { FactoryBot.create(:comment) }
  let(:tag) { FactoryBot.create(:tag) }
  describe 'トップページ' do
    context 'ページレイアウト' do
      before do
        visit root_path
      end

      it 'Myごはんの文字列が存在すること' do
        expect(page).to have_content 'なんでも掲示板'
      end

      it '正しいページタイトルが表示されること' do
        expect(page).to have_title 'なんでも掲示板-top_page'
      end

      context 'スレッド関係'
      it 'タグ検索ができること'

      it 'タイトルで検索できること' do
        topic
        fill_in 'search', with: topic.title.to_s
        click_button '検索'
        expect(page).to have_content topic.title.to_s
      end

      it 'スレッド内のコメントが検索できること' do
        comment
        fill_in 'search', with: comment.content.to_s
        click_button '検索'
        expect(page).to have_content comment.topic.title.to_s
      end
    end
  end
end
