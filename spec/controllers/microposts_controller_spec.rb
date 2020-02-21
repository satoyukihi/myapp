require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  let(:user) {FactoryBot.create(:user)}
  let(:micropost) {FactoryBot.create(:micropost)}
  let(:micropost_params) {FactoryBot.attributes_for(:micropost)}
  
  describe "#new" do
      
      it "正常にレスポンスを返すこと" do
        log_in_as(user)
        get :new
        expect(response).to be_success
      end
    
      it "200レスポンスを返すこと" do
        log_in_as(user)
        get :new
        expect(response).to have_http_status "200"
     end
    end
    
    context"認可されていないユーザーとして" do
      it "302レスポンスを返すこと" do
        get :new
        expect(response).to have_http_status"302"
      end
    
      it "サインイン画面にリダイレクトすること" do
        get :new
        expect(response).to redirect_to "/login"
      end
    end
  
  

  describe "show" do
    
      it "正常にレスポンスを返すこと" do
        log_in_as(user)
        get :show, params: {id: micropost.id}
        expect(response).to be_success
      end
      
      it "認可されていないユーザーとしてレスポンスを返すこと" do
        get :show, params: {id: micropost.id}
        expect(response).to be_success
       end
     end
  
  
  describe "create" do
    context "認可されているユーザーとして" do
      
       it "マイクロポストを作成できること" do
        log_in_as(user)
         expect{
         post :create , params:{micropost: micropost_params}}.to change(user.microposts, :count).by(1)
        end
    end    
    
    context"認可されていないユーザーとして" do
      
      it "302レスポンスを返すこと" do
        post :create , params:{micropost: micropost_params}
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトすること" do
        post :create , params:{micropost: micropost_params}
        expect(response).to redirect_to "/login"
      end
    end  
  end


  describe "destroy" do
    context "認可されているユーザーとして" do
      before do
        @user      = FactoryBot.create(:user)
        @micropost = FactoryBot.create(:micropost, user_id: @user.id)
      end
        
      
       it "マイクロポストを削除できること" do
         log_in_as(@user)
         expect{
         delete :destroy , params:{id: @micropost.id}}.to change(@user.microposts, :count).by(-1)
       end
    end
    
    context "認可されていないユーザーとして" do
      
      it "マイクロポストを削除できないこと" do
        log_in_as(user)
        micropost
        expect{
        delete :destroy , params:{ id: micropost.id}}.to_not change(Micropost, :count)
      end 
      
      it "ホーム画面にリダイレクトすること" do
        log_in_as(user)
        micropost
        delete :destroy , params:{id: micropost.id}
        expect(response).to redirect_to "/"
      end
    end  
    
    context "ゲストユーザーとして" do
      
      it "マイクロポストを削除できないこと" do
        micropost
        expect{
        delete :destroy , params:{ id: micropost.id}}.to_not change(Micropost, :count)
      end 
      
      it "ホーム画面にリダイレクトすること" do
        micropost
        delete :destroy , params:{id: micropost.id}
        expect(response).to redirect_to "/login"
      end
    end  
  end
end