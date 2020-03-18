FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tagt#{n}" }
  end
end
