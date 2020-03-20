require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }
  context 'カラムのバリテーション' do
    it 'content、user_id、topic_idがあれば有効であること' do
      comment.valid?
      expect(comment).to be_valid
    end

    it 'commentがない場合無効な状態であること' do
      comment = Comment.new(content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include('を入力してください')
    end

    it 'user_idがない場合無効な状態であること' do
      comment = Comment.new(user_id: nil)
      comment.valid?
      expect(comment.errors[:user_id]).to include('を入力してください')
    end

    it 'micropost_idがない場合無効な状態であること' do
      comment = Comment.new(micropost_id: nil)
      comment.valid?
      expect(comment.errors[:micropost_id]).to include('を入力してください')
    end

    it 'contentが140文字以上の場合無効な状態であること' do
      comment = Comment.new(content: 'a' * 141)
      comment.valid?
      expect(comment.errors[:content]).to include('は140文字以内で入力してください')
    end
  end
end
