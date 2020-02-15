class FavoriteRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true
end

#"user_idがなければ無効な状態であること"
#"micropost_idがなければ無効な状態であること"
#"二回いいねできないこと"