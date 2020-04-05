FactoryBot.define do
  factory :notification do
    visitor factory: :user
    visited factory: :user
    micropost
    comment
    checked false

    trait :like do
      action 'like'
    end

    trait :follow do
      action 'follow'
    end

    trait :comment do
      action 'comment'
    end
  end
end
