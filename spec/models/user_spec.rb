require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do 
    
    @user = User.new(
      name:                  "Aaron" ,
      email:                 "tster@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      )
    end
    
  it "名前、メール、パスワードがあれば有効な状態であること" do
      expect(@user).to be_valid
  end
      
  it "名前がなければ無効な状態であること" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  
  it "名前が51文字以上あれば無効な状態であること" do
    user = User.new(name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end
  
  it "メールがなければ無効な状態であること" do
    user =User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  it "重複したメールアドレスなら無効な状態であること" do
    User.create(
      name:                  "Aaron",
      email:                 "tster@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      )
      
    user =User.new(
      name:                  "Jane",
      email:                 "tster@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
    
    
  it "メールが256文字以上あれば無効な状態であること" do
    user = User.new(email: "a" * 256)
    user.valid?
    expect(user.errors[:email]).to include("は255文字以内で入力してください")
  end
  
  
  it "メールのフォーマットが合わなければ無効な状態であること" do
    user = User.new(email: "foo")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end
  
  it "入力された大文字のメールと登録された小文字のメールが同じであること" do
    user =User.create(
      name:                  "Aaron",
      email:                 "TSTeR@Example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      )
    expect(user.email).to eq "tster@example.com"
  end
  
  
  
  it "パスワードがなければ無効な状態であること" do
    user = User.new(password: nil, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  
  
  it "パスワードが5文字以下なら無効な状態であること" do
    user = User.new(password: "a" * 5, password_confirmation: "a" * 5)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
  
  it "ユーザー情報編集の時はパスワードがなくても編集できること" do #allow_nilをコメントアウトしてもテスト通るからそのうち考える
    @user.update_attributes(
      name:                   "Jane",
      email:                  "test@example.com",
      )
      
      expect(@user).to be_valid
   end
    
    
      
  it "パスワードとパスワード確認が一致しないなら無効な状態であること" do
    user = User.new(password: "foobar", password_confirmation: "foobarrrr")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    #コンフィらメンション側のテスト
  end
      
  it "パスワードが一致すればUserオブジェクトを返すこと" do
      expect(@user.authenticate("foobar")).to eq @user
  end
  
  describe User do
    it "有効なファクトリを持つこと" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
end