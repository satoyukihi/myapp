class User < ApplicationRecord
  #名前空＋長さ50
  validates :name, presence: true, length: { maximum: 50 }
  #emailフォーマット定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #email空＋長さ50＋フォーマット+ユニーク（大文字）小文字区別なし
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
