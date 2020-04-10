class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships
  has_many :favorite_relationships, dependent: :destroy
  has_many :liked_by, through: :favorite_relationships, source: :user
  has_many :notifications, dependent: :destroy
  default_scope -> { order(created_at: :desc) } # 作成順から並ぶように
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 250 }
  validates :picture, presence: true
  validate  :picture_size

  # タグを作成・更新する
  def save_tags(savemicropost_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - savemicropost_tags
    new_tags = savemicropost_tags - current_tags

    new_tags.each do |new_name|
      micropost_tag = Tag.find_or_create_by(name: new_name)
      return false unless micropost_tag.valid?

      tags << micropost_tag
    end

    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end
  end

  # タイトル・本文・コメントから検索
  def self.micropost_serach(search)
    Micropost.eager_load(:comments).where(['microposts.title LIKE ? OR microposts.content LIKE ? OR comments.content LIKE ?',
                                           "%#{search}%", "%#{search}%", "%#{search}%"])
  end

  # 通知機能
  def create_notification_like!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and micropost_id = ? and action = ? ',
                               current_user.id, user_id, id, 'like'])
    return if temp.present?

    notification = current_user.active_notifications.new(
      micropost_id: id,
      visited_id: user_id,
      action: 'like'
    )

    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    # 同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = Comment.where(micropost_id: id).where.not('user_id=? or user_id=?', current_user.id, user_id).select(:user_id).distinct
    # 取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # 投稿者へ通知を作成
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    errors.add(:picture, '5MB以上の画像はアップロードできません') if picture.size > 5.megabytes
  end
end
