FactoryBot.define do
  factory :comment do
    user
    micropost
    content 'comment'
  end
end
