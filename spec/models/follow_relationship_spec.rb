require 'rails_helper'

RSpec.describe FollowRelationship, type: :model do
  let(:follow_relationship) {FactoryBot.create(:follow_relationship)}
  before do
    follow_relationship
  end

  it 'follower_idと:following_idがあれば有効であること' do
    follow_relationship.valid?
    expect(follow_relationship).to be_valid
  end

  it 'follower_idがなければ無効な状態であること' do
    follower = FactoryBot.build(:follow_relationship, follower_id: nil)
    follower.valid?
    expect(follower.errors[:follower_id]).to include('を入力してください')
  end

  it 'following_idがなければ無効な状態であること' do
    follow = FactoryBot.build(:follow_relationship, following_id: nil)
    follow.valid?
    expect(follow.errors[:following_id]).to include('を入力してください')
  end

  it 'follower_idとfollowing＿idがユニークでない場合無効な状態であること' do
    follow = FactoryBot.build(:follow_relationship,
                             follower_id: follow_relationship.follower_id,
                             following_id: follow_relationship.following_id)
    follow.valid?
    expect(follow.errors[:follower_id]).to include('はすでに存在します')
  end
end
