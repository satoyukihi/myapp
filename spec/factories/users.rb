FactoryBot.define do
  
  factory :user do
    name                  "Aaron" 
    sequence(:email)      { |n| "tster#{n}@example.com"}
    password              "foobar"
    password_confirmation "foobar"
  end
    
end
