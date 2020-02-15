require 'rails_helper'

RSpec.describe FavoriteRelationship, type: :model do
  it "マイクロポストidとユーザーidがあれば有効であること" do
    expect(FactoryBot.build(:favorite_relationship)).to be_valid 
  end
  
  it "ユーザーidがなければ無効な状態であること" do
    like = FactoryBot.build(:favorite_relationship, user_id: nil)
    like.valid?
    expect(like.errors[:user_id]).to include("を入力してください")
  end
  
  it "マイクロポストidがなければ無効な状態であること" do
    like = FactoryBot.build(:favorite_relationship, micropost: nil)
    like.valid?
    expect(like.errors[:micropost_id]).to include("を入力してください")
  end
  
  
  
  #it "関連データー生成" do
    #like = FactoryBot.build(:favorite_relationship)
    #puts like.user.inspect
    #puts like.micropost.inspect
  #end
end
