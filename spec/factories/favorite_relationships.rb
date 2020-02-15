FactoryBot.define do
  
  factory :favorite_relationship do
    
    association :micropost
    association :user
  end
end
