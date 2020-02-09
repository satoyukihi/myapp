class User < ApplicationRecord
  #ユーザーセーブ前にemailをすべて小文字にする
  before_save { self.email = email.downcase }
  #名前空＋長さ50
  validates :name, presence: true, length: { maximum: 50 }
  #emailフォーマット定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #email空＋長さ50＋フォーマット+ユニーク（大文字）小文字区別なし
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #authenticateメゾットが使える。パスワード一致でUserオブジェクトを返す。パスワードのバリテーションも追加
  has_secure_password
  #空でない＋最小6文字＋ユーザー情報編集の際にパスワードがからでもOK
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
