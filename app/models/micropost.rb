class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorite_relationships, dependent: :destroy
  has_many :liked_by, through: :favorite_relationships, source: :user
  default_scope -> { order(created_at: :desc) }#作成順から並ぶように
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 250 }
  validates :picture, presence: true
  validate  :picture_size
  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB以上の画像はアップロードできません")
      end
    end
end

#"ユーザーIDがなければ無効な状態であること"
#"タイトルがなければ無効な状態であること"
#"タイトルが30文字以上であれば無効な状態であること"
#"本文がなければ無効な状態であること"
#"本文が250文字以上あれば無効な状態であること"
#"写真がなければ無効な状態であること"
#"写真の容量が5MB以上あれば無効な状態であること"

