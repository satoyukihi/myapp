require 'rails_helper'

RSpec.describe FavoriteRelationship, type: :model do
  it 'マイクロポストidとユーザーidがあれば有効であること' do
    expect(FactoryBot.build(:favorite_relationship)).to be_valid
  end

  it 'ユーザーidがなければ無効な状態であること' do
    like = FactoryBot.build(:favorite_relationship, user_id: nil)
    like.valid?
    expect(like.errors[:user_id]).to include('を入力してください')
  end

  it 'マイクロポストidがなければ無効な状態であること' do
    like = FactoryBot.build(:favorite_relationship, micropost: nil)
    like.valid?
    expect(like.errors[:micropost_id]).to include('を入力してください')
  end

  it 'user_idとmicropost＿idがユニークでない場合無効な状態であること' do
    micropost = FactoryBot.create(:micropost)

    like  = FactoryBot.create(:favorite_relationship,
                              user_id: micropost.user_id,
                              micropost_id: micropost.id)

    like2 = FactoryBot.build(:favorite_relationship,
                             user_id: micropost.user_id,
                             micropost_id: micropost.id)
    like2.valid?
    expect(like2.errors[:user_id]).to include('はすでに存在します')
  end
end
