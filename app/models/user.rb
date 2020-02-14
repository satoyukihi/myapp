class User < ApplicationRecord
  
  
  has_many :microposts, dependent: :destroy
  has_many :favorite_relationships, dependent: :destroy
  has_many :likes, through: :favorite_relationships, source: :micropost
  
  #ユーザーセーブ前にemailをすべて小文字にする
  before_save { self.email = email.downcase }
  
  #emailフォーマット定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  #名前空＋長さ50
  validates :name, presence: true, length: { maximum: 50 }
  
  #email空＋長さ255＋フォーマット+ユニーク（大文字）小文字区別なし
  
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  #空でない＋最小6文字＋ユーザー情報編集の際にパスワードがからでもOK
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  #authenticateメゾットが使える。パスワード一致でUserオブジェクトを返す。パスワードのバリテーションも追加
  has_secure_password
  
  
  
  
  
  def feed
    Micropost.where("user_id = ?", id)
  end
  
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
  
end
