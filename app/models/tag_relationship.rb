class TagRelationship < ApplicationRecord
  belongs_to :micropost
  belongs_to :tag
  validates :micropost_id, presence: true
  validates :tag_id, presence: true
  validates :micropost_id, uniqueness: { scope: :tag_id }
end
