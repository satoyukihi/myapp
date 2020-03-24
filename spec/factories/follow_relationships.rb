FactoryBot.define do
  factory :follow_relationship do
    association :follower, factory: :user
    association :following, factory: :user 
  end
end
