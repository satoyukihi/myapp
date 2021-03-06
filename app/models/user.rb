class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :favorite_relationships, dependent: :destroy
  has_many :likes, through: :favorite_relationships, source: :micropost

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'FollowRelationship', dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'FollowRelationship', dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :active_notifications, foreign_key: 'visitor_id', class_name: 'Notification', dependent: :destroy
  has_many :passive_notifications, foreign_key: 'visited_id', class_name: 'Notification', dependent: :destroy
  # ユーザーセーブ前にemailをすべて小文字にする
  before_save { self.email = email.downcase }

  # emailフォーマット定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  # 名前空＋長さ50
  validates :name, presence: true, length: { maximum: 50 }

  # email空＋長さ255＋フォーマット+ユニーク（大文字）小文字区別なし

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # 空でない＋最小6文字＋ユーザー情報編集の際にパスワードがからでもOK
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/.freeze
  validates :password, presence: true,
                       allow_nil: true,
                       format: { with: VALID_PASSWORD_REGEX,
                                 message: 'は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります' }

  # authenticateメゾットが使える。パスワード一致でUserオブジェクトを返す。パスワードのバリテーションも追加
  has_secure_password

  # マイクロポストをライクする
  def like(micropost)
    likes << micropost
  end

  # マイクロポストをライク解除する
  def unlike(micropost)
    favorite_relationships.find_by(micropost_id: micropost.id).destroy
  end

  # 現在のユーザーがライクしていたらtrueを返す
  def likes?(micropost)
    likes.include?(micropost)
  end

  # すでにフォロー済みであればture返す
  def following?(other_user)
    followings.include?(other_user)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  # ユーザーのフォローを解除する
  def unfollow(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def create_notification_follow!(current_user)
    # すでに通知が作成されているか確認
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    return if temp.present?

    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end

  # フォローしているユーザーを取得
  def feed
    following_ids = 'SELECT following_id FROM follow_relationships WHERE follower_id =:user_id'
    Micropost.where("user_id IN (#{following_ids})
              OR user_id =:user_id", user_id: id)
  end
end
