require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { FactoryBot.create(:tag) }

  context 'カラムのバリテーション' do
    before do
      tag
    end

    it 'nameがあれば有効であること' do
      tag.valid?
      expect(tag).to be_valid
    end

    it 'nameが重複している場合無効な状態であること' do
      tag
      other_tag = Tag.new(name: tag.name)
      other_tag.valid?
      expect(other_tag.errors[:name]).to include('はすでに存在します')
    end
  end
end
