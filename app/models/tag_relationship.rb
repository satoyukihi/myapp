class TagRelationship < ApplicationRecord
  belongs_to :micropst
  belongs_to :tag
end
