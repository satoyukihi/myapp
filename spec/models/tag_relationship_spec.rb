require 'rails_helper'

RSpec.describe TagRelationship, type: :model do
  let(:micropost) { FactoryBot.create(:micropost) }
  let(:tag_relationship) { FactoryBot.create(:tag_relationship) }
  context 'カラムのバリテーション' do
    before do
      tag_relationship
    end

    it 'micropost_id、tag_idがあれば有効であること' do
      tag_relationship.valid?
      expect(tag_relationship).to be_valid
    end

    it 'micropost_idがない場合無効な状態であること' do
      tag_relationship.update(micropost_id: nil)
      tag_relationship.valid?
      expect(tag_relationship.errors[:micropost]).to include('を入力してください')
    end

    it 'tag_idがない場合無効な状態であること' do
      tag_relationship.update(tag_id: nil)
      tag_relationship.valid?
      expect(tag_relationship.errors[:tag]).to include('を入力してください')
    end
  end
end