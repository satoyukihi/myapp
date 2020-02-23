require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user)       {FactoryBot.create(:user)}
  let(:other_user) {FactoryBot.create(:user)}
  let(:user_admin) {FactoryBot.create(:user, admin: true)}
  let(:micropost)  {FactoryBot.create(:micropost)}
  let(:micropost8) {FactoryBot.create_list(:micropost,8,user_id: user.id)}
  
  it "新しいユーザーを作成する" do
    expect{
      visit root_path
      click_link "新規ユーザー登録"
      fill_in "user[name]", with: "yuki"
      fill_in "user[email]", with: "test@example.com"
      fill_in "user[password]", with: "foobar"
      fill_in "user[password_confirmation]", with: "foobar"
      click_button "作成"
    
      expect(page).to have_content "ユーザー登録完了！Myごはんへようこそ！！"
    }.to change(User, :count).by(1)
  end
  
  it "ユーザー自身がユーザー情報を編集する" do
    sign_in_as user
    click_link "ようこそ#{user.name}さん‼"
    click_link "編集ページへ"
    fill_in "user[name]", with: "yuki"
    fill_in "user[email]", with: "test@example.com"
    click_button "編集"
    
    expect(page).to have_content "ユーザー情報を編集しました‼"
    expect(page).to have_content "yuki"
  end  
  
  it "他のユーザーページで編集が表示されないこと" do
    user
    sign_in_as(other_user)
    visit user_path(user)
    expect(page).to_not have_content "編集"
  end
    
  it "管理者としてユーザーを削除する" do
    user
    sign_in_as(user_admin)
      expect{
        visit user_path(user)
        click_link "ユーザー削除"
        expect(page).to have_content "ユーザーを削除しました"
      }.to change(User, :count).by(-1)
  end
  
  it "ユーザーが自身を削除する" do
     user
     sign_in_as(user)
     expect{
        visit user_path(user)
        click_link "ユーザー削除"
        expect(page).to have_content "ユーザーを削除しました"
      }.to change(User, :count).by(-1)
  end
    
  it "他のユーザーページで削除が表示されないこと" do
    user
    sign_in_as(other_user)
    visit user_path(user)
    expect(page).to_not have_content "ユーザー削除"
  end
=begin
  describe "マイクロポストの表示（検索、ページネーション）" do
    
    it "マイクロポストのタイトル検索、ページネーションが機能していること" do
      micropost8
      visit root_path
      expect(page).to have_content "件の投稿が表示されています"
      expect(page).to have_link "次"
    
      expect(page).to_not have_content "test1"
      fill_in "q_title_cont", with: "test1"
      click_button "検索"
      expect(page).to have_content "test1"
  
      sign_in_as(user)
      visit user_path(user)
      expect(page).to have_content "件の投稿が表示されています"
      expect(page).to have_link "次"
    end
  end
=end
end