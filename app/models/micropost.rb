class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }#作成順から並ぶように
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 500 }
end
