FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag#{n}" }

    after(:create) do |tag|
      create(:tag_relationship, tag: tag, micropost: create(:micropost))
    end
  end
end
