FactoryBot.define do
  
  factory :micropost do
    sequence(:title)       {|n|"test#{n}"}
    content                "testcontent"
    picture                Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))
    user
  end
end
