require 'rails_helper'

RSpec.describe FavoriteRelationshipsController, type: :controller do
      let(:user)        {FactoryBot.create(:user)}
      let(:micropost)   {FactoryBot.create(:micropost)}
      
      let(:iine)        {FactoryBot.create(:favorite_relationship,
                                          user_id:       user.id, 
                                     micropost_id:  micropost.id )}
                                     
      let(:iine_params) {FactoryBot.attributes_for(
                                 :favorite_relationship, 
                                 user_id: user.id, 
                            micropost_id: micropost.id)}
                            
      
                          
                            
  describe "create" do
                            
    context "認可されているユーザーとして" do
      
       it "いいねできること" do
        log_in_as(user)
         expect{
         post :create , params: iine_params}.to change(user.likes, :count).by(1)
       end
    end
    
    context"認可されていないユーザーとして" do
      
      it "302レスポンスを返すこと" do
        post :create 
        expect(response).to have_http_status "302"
      end
      
      it "ログイン画面にリダイレクトすること" do
        post :create 
        expect(response).to redirect_to "/login"
      end
    end  
  end

  describe "destroy" do
    
    context "認可されているユーザーとして" do
      
       it "いいねを解除できること" do
         log_in_as(user)
         iine
         expect{
         delete  :destroy , params:{id: iine.id, 
                              user_id: user.id, 
                         micropost_id: micropost.id}
           
         }.to change(user.likes, :count).by(-1)
       end
    end   
    
    context "認可されていないユーザーとして" do
      
      it "いいねを解除できないこと" do
        iine
        expect{
        delete  :destroy , params:{id: iine.id, 
                              user_id: user.id, 
                         micropost_id: micropost.id}
          
        }.to_not change(user.likes, :count)
      end 
      
      it "ログイン画面にリダイレクトすること" do
        delete :destroy , params:{id: iine.id, 
                             user_id: user.id, 
                        micropost_id: micropost.id}
        expect(response).to redirect_to "/login"
      end
      
    end
  end
end