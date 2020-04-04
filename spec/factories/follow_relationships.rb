FactoryBot.define do
  factory :follow_relationship do
    follower factory: :user
    following factory: :user
  end
end
