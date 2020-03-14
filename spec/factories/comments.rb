FactoryBot.define do
  factory :comment do
    user
    micropost
    content "MyText"
  end
end
