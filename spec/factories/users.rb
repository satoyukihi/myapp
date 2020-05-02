FactoryBot.define do
  factory :user do
    name                  'Aaron'
    sequence(:email)      { |n| "tster#{n}@example.com" }
    password              'foobar12A'
    password_confirmation 'foobar12A'
  end
end
