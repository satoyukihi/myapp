require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "正常にレスポンスを返すこと" do
      get :new
      expect(response).to be_success
    end

  
   it "200レスポンスを返すこと" do
     get :new
     expect(response).to have_http_status "200"
   end
 end
 
 describe "#create" do
   before "新規ユーザー登録" do
     @user_params =FactoryBot.attributes_for(:user)
   end
   
    it "ユーザー作成できること" do
      expect{
         post :create , params:{user: @user_params}}.to change(User, :count).by(1)
    end

  
   it "作成後ホームページに戻ること" do
     post :create , params:{user: @user_params}
     expect(response).to redirect_to "/"
   end
 end
 
 describe"show" do
    before do
     @user = FactoryBot.create(:user)
   end
   
     it"正常にレスポンスを返すこと" do
       get :show, params:{ id: @user.id}
       expect(response).to be_success
     end
     
     it"ゲストユーザーでも正常なレスポンスを返すこと" do
       get :show, params:{ id: @user.id}
       expect(response).to be_success
     end
  end
  
  describe "#edit" do
   before "認可されているユーザーとして" do
     @user=FactoryBot.create(:user)
   end
   
    it "編集ページへアクセスできること" do
      log_in_as(@user)
      get :edit, params:{ id: @user.id}
      expect(response).to be_success
    end
    
    it "200レスポンスを返すこと" do
    log_in_as(@user)
     get :edit, params:{ id: @user.id}
     expect(response).to have_http_status "200"
   end

   context"許可されていないユーザーとして" do
     
     it "302レスポンスを返すこと" do
        get :edit, params:{ id: @user.id}
        expect(response).to have_http_status"302"
      end
    
      it "サインイン画面にリダイレクトすること" do
        get :edit, params:{ id: @user.id}
        expect(response).to redirect_to "/login"
      end
   end 
  end
  
  describe "update" do
    
    context "認可されているユーザーとして" do
      before do
        @user             = FactoryBot.create(:user)
        @other_user        = FactoryBot.create(:user)
        @user_params      = FactoryBot.attributes_for(:user, name:"New User Name")
      end
      
       it "ユーザ情報を編集できること" do
        log_in_as(@user)
        patch :update, params: {id: @user.id, user: @user_params}
        expect(@user.reload.name).to eq "New User Name"
       end
     
       
      context"別のユーザーとして" do
        
        it "ユーザー情報を編集できないこと" do
         log_in_as(@other_user)
          patch :update, params: {id: @user.id, user: @user_params}
          expect(response).to have_http_status "302"
        end
        
        it "ホーム画面にリダイレクトすること" do
          patch :update, params: {id: @user.id, user: @user_params}
          expect(response).to redirect_to "/login"
        end
      end
    
    
      context"認可されていないユーザーとして" do
        
        it "302レスポンスを返すこと" do
          patch :update, params: {id: @user.id, user: @user_params}
          expect(response).to have_http_status "302"
        end
      
        it "ログイン画面にリダイレクトすること" do
          patch :update, params: {id: @user.id, user: @user_params}
          expect(response).to redirect_to "/login"
        end
      end  
    end
  end
  
  describe "destroy" do
    context "認可されているユーザーとして" do
      
      before do
        @user_admin = FactoryBot.create(:user, admin: true)
        @user       = FactoryBot.create(:user)
      end
      
       it "ユーザーを削除できること" do
         log_in_as(@user_admin)
         expect{
          delete :destroy , params:{id: @user.id}}.to change(User, :count).by(-1)
       end
    
    context "認可されていないユーザーとして" do
      
      
      it "ユーザーを削除できないこと" do
        log_in_as(@user)
        expect{
         delete :destroy , params:{id: @user_admin.id}}.to_not change(User, :count)
      end 
      
      it "ホーム画面にリダイレクトすること" do
        log_in_as(@user)
        delete :destroy , params:{id: @user_admin.id}
        expect(response).to redirect_to "/"
      end
      
    end  
    
    context "ゲストユーザーとして" do
      
      it "マイクロポストを削除できないこと" do
        expect{
         delete :destroy , params:{id: @user_admin.id}}.to_not change(User, :count)
      end 
      
      it "ログイン画面にリダイレクトすること" do
        delete :destroy , params:{id: @user_admin.id}
        expect(response).to redirect_to "/login"
      end
    end  
  end
 end
 
 describe "likes" do
   context"認可されているユーザーとして" do
     
    before do
     @user       = FactoryBot.create(:user)
     @other_user = FactoryBot.create(:user)
    end
   
    it"自分のいいね一覧ページにアクセスできること" do
      log_in_as(@user)
      get :likes, params:{ id: @user.id}
      expect(response).to be_success
    end
     
    it"ほかのユーザーのいいねページにもアクセスできること" do
      log_in_as(@user)
     get :likes, params:{ id: @other_user.id}
     expect(response).to be_success
    end
    
    context"認可されていないユーザーとして" do
      
       it "302レスポンスを返すこと" do
        get :likes, params:{ id: @user.id}
        expect(response).to have_http_status"302"
       end
    
       it "サインイン画面にリダイレクトすること" do
        get :likes, params:{ id: @user.id}
        expect(response).to redirect_to "/login"
       end
     end
   end
  end
   
end