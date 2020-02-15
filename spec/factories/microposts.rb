FactoryBot.define do
  
  factory :micropost do
    title       "test"
    content     "testcontent"
    picture     Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))
    association :user
  end
end
