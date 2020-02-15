require 'rails_helper'

RSpec.describe Micropost, type: :model do
  
  it "タイトル、本文、写真、ユーザーidがあれば有効な状態であること" do
    
    expect(FactoryBot.build(:micropost)).to be_valid  
  end
  
  #it "投稿順にならんでいること" do
    #micropost = FactoryBot.create(:micropost)
      
    #after_micropost = FactoryBot.create(:micropost)
      
      #expect(after_micropost).to eq Micropost.first #1にしたらちゃんと失敗した
    #end
  
  it "ユーザーIDがなければ無効な状態であること" do
    micropost = Micropost.new(user_id: nil)
    micropost.valid?
    expect(micropost.errors[:user_id]).to include("を入力してください")
  end
  
   it "タイトルがなければ無効な状態であること" do
     micropost = Micropost.new(title: nil)
     micropost.valid?
    expect(micropost.errors[:title]).to include("を入力してください")
     
   end
     
    it "タイトルが31文字以上であれば無効な状態であること" do
      micropost = Micropost.new(title: "a" * 31)
      micropost.valid?
      expect(micropost.errors[:title]).to include("は30文字以内で入力してください")
    end
    
  it "本文がなければ無効な状態であること" do
    micropost = Micropost.new(content: nil)
    micropost.valid?
    expect(micropost.errors[:content]).to include("を入力してください")
  end
  
  it "本文が251文字以上あれば無効な状態であること" do
    micropost = Micropost.new(content: "a" * 251)
    micropost.valid?
    expect(micropost.errors[:content]).to include("は250文字以内で入力してください")
  end
  
  it "写真がなければ無効な状態であること" do
    micropost = Micropost.new(picture: nil)
    micropost.valid?
    expect(micropost.errors[:picture]).to include("を入力してください")
  end 
  
  it "関連データー生成" do
   micropost = FactoryBot.create(:micropost)
   puts micropost.user.inspect
   end
  
end
