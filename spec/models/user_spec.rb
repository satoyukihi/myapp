require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
      name: 'Aaron',
      email: 'tster@example.com',
      password: 'foobar12A',
      password_confirmation: 'foobar12A'
    )
  end

  it '名前、メール、パスワードがあれば有効な状態であること' do
    expect(@user).to be_valid
  end

  it '名前がなければ無効な状態であること' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it '名前が51文字以上あれば無効な状態であること' do
    user = User.new(name: 'a' * 51)
    user.valid?
    expect(user.errors[:name]).to include('は50文字以内で入力してください')
  end

  it 'メールがなければ無効な状態であること' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it '重複したメールアドレスなら無効な状態であること' do
    User.create(
      name: 'Aaron',
      email: 'tster@example.com',
      password: 'foobarA12',
      password_confirmation: 'foobarA12'
    )

    user = User.new(
      name: 'Jane',
      email: 'TSTER@example.com',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
    user.valid?
    expect(user.errors[:email]).to include('はすでに存在します')
  end

  it 'メールが256文字以上あれば無効な状態であること' do
    user = User.new(email: 'a' * 256)
    user.valid?
    expect(user.errors[:email]).to include('は255文字以内で入力してください')
  end

  it 'メールのフォーマットが合わなければ無効な状態であること' do
    user = User.new(email: 'foo')
    user.valid?
    expect(user.errors[:email]).to include('は不正な値です')
  end

  it '入力された大文字のメールと登録された小文字のメールが同じであること' do
    user = User.create(
      name: 'Aaron',
      email: 'TSTeR@Example.com',
      password: 'foobar12A',
      password_confirmation: 'foobar12A'
    )
    expect(user.email).to eq 'tster@example.com'
  end

  it 'パスワードがなければ無効な状態であること' do
    user = User.new(password: nil, password_confirmation: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  it 'パスワードに英小文字が含まれない場合無効な状態であること' do
    user = User.new(password: '1'+'A' * 5, password_confirmation: '1A'+'a' * 3)
    user.valid?
    expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
  end

  it 'パスワードに英大文字が含まれない場合無効な状態であること' do
    user = User.new(password: '1'+'a' * 5, password_confirmation: '1A'+'a' * 3)
    user.valid?
    expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
  end

  it 'パスワードに数字が含まれない場合無効な状態であること' do
    user = User.new(password: 'A'+'a' * 5, password_confirmation: '1A'+'a' * 3)
    user.valid?
    expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
  end

  it 'パスワードが5文字以下なら無効な状態であること' do
    user = User.new(password: '1A'+'a' * 3, password_confirmation: '1A'+'a' * 3)
    user.valid?
    expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
  end

  it 'パスワードが13文字以上なら無効な状態であること' do
    user = User.new(password: '1A'+'a' * 11, password_confirmation: '1A'+'a' * 11)
    user.valid?
    expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
  end

  it 'ユーザー情報編集の時はパスワードがなくても編集できること' do # allow_nilをコメントアウトしてもテスト通るからそのうち考える
    @user.update(
      name: 'Jane',
      email: 'test@example.com'
    )

    expect(@user).to be_valid
  end

  it 'パスワードとパスワード確認が一致しないなら無効な状態であること' do
    user = User.new(password: 'foobar12A', password_confirmation: 'foobarrrr12A')
    user.valid?
    expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
  end

  it 'パスワードが一致すればUserオブジェクトを返すこと' do
    expect(@user.authenticate('foobar12A')).to eq @user
  end
end
