require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "#home" do
    it "正常にレスポンスを返すこと" do
      get :home
      expect(response).to be_success
    end

  
   it "200レスポンスを返すこと" do
     get :home 
     expect(response).to have_http_status "200"
   end
  end
end
