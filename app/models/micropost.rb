class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships
  has_many :favorite_relationships, dependent: :destroy
  has_many :liked_by, through: :favorite_relationships, source: :user
  default_scope -> { order(created_at: :desc) } # 作成順から並ぶように
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 250 }
  validates :picture, presence: true
  validate  :picture_size
  
  
  def save_tags(savemicropost_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - savemicropost_tags
    new_tags = savemicropost_tags - current_tags

    new_tags.each do |new_name|
      micropost_tag = Tag.find_or_create_by(name: new_name)
      if micropost_tag.valid?
        tags << micropost_tag
      else
        return false
      end
    end
    
    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end
  end

  def self.micropost_serach(search)
    Micropost.eager_load(:comments).where(['microposts.title LIKE ? OR microposts.content LIKE ? OR comments.content LIKE ?',
                                         "%#{search}%", "%#{search}%", "%#{search}%"])
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    errors.add(:picture, '5MB以上の画像はアップロードできません') if picture.size > 5.megabytes
  end
end
