FactoryBot.define do
  factory :tag_relationship do
    association :micropost
    association :tag
  end
end
