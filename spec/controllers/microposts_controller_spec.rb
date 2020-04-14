require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost) }
  let(:micropost_params) { FactoryBot.attributes_for(:micropost) }

  describe '#new' do
    it '正常にレスポンスを返すこと' do
      log_in_as(user)
      get :new
      expect(response).to be_success
    end

    it '200レスポンスを返すこと' do
      log_in_as(user)
      get :new
      expect(response).to have_http_status '200'
    end
  end

  context '認可されていないユーザーとして' do
    it '302レスポンスを返すこと' do
      get :new
      expect(response).to have_http_status '302'
    end

    it 'サインイン画面にリダイレクトすること' do
      get :new
      expect(response).to redirect_to '/login'
    end
  end

  describe 'show' do
    it '正常にレスポンスを返すこと' do
      log_in_as(user)
      get :show, params: { id: micropost.id }
      expect(response).to be_success
    end

    it '認可されていないユーザーとしてレスポンスを返すこと' do
      get :show, params: { id: micropost.id }
      expect(response).to be_success
    end
  end

  describe 'edit' do
    before do
      @user = FactoryBot.create(:user)
      @micropost = FactoryBot.create(:micropost, user_id: @user.id)
    end

    it '正常にレスポンスを返すこと' do
      log_in_as(@user)
      get :edit, params: { id: @micropost.id }
      expect(response).to be_success
    end

    it '認可されていないユーザーとしてレスポンスを返すこと(ゲストユーザー)' do
      get :edit, params: { id: @micropost.id }
      expect(response).to have_http_status '302'
    end

    it 'ログイン画面にリダイレクトすること(ゲストユーザー)' do
      post :edit, params: { id: @micropost.id }
      expect(response).to redirect_to '/login'
    end

    it '認可されていないユーザーとしてレスポンスを返すこと(他のユーザー)' do
      get :edit, params: { id: @micropost.id }
      expect(response).to have_http_status '302'
    end

    it 'ホーム画面にリダイレクトすること(他のユーザー)' do
      log_in_as(user)
      delete :edit, params: { id: @micropost.id }
      expect(response).to redirect_to '/'
    end
  end

  describe 'update' do
    before do
      @user = FactoryBot.create(:user)
      @micropost = FactoryBot.create(:micropost, user_id: @user.id)
    end

    #it '正常にレスポンスを返すこと' do
      #log_in_as(@user)
      #get :update, params: { id: @micropost.id }
      #expect(response).to be_success
    #end
    it '認可されていないユーザーとしてレスポンスを返すこと(ゲストユーザー)' do
      get :update, params: { id: @micropost.id }
      expect(response).to have_http_status '302'
    end

    it 'ログイン画面にリダイレクトすること(ゲストユーザー)' do
      post :update, params: { id: @micropost.id }
      expect(response).to redirect_to '/login'
    end

    it '認可されていないユーザーとしてレスポンスを返すこと(他のユーザー)' do
      get :update, params: { id: @micropost.id }
      expect(response).to have_http_status '302'
    end

    it 'ホーム画面にリダイレクトすること(他のユーザー)' do
      log_in_as(other_user)
      delete :update, params: { id: @micropost.id }
      expect(response).to redirect_to '/'
    end
  end

  describe 'create' do
    #context '認可されているユーザーとして' do
      #it 'マイクロポストを作成できること' do
       # log_in_as(user)
        #expect do
        #  post :create, params: { micropost: micropost_params }
        #end .to change(user.microposts, :count).by(1)
      #end

      context '認可されていないユーザーとして(ゲストユーザー)' do
        it '302レスポンスを返すこと' do
          post :create, params: { micropost: micropost_params }
          expect(response).to have_http_status '302'
        end

        it 'ログイン画面にリダイレクトすること(ゲストユーザー)' do
          post :create, params: { micropost: micropost_params }
          expect(response).to redirect_to '/login'
        end
      end
    #end
  end

  describe 'destroy' do
    context '認可されているユーザーとして' do
      before do
        @user      = FactoryBot.create(:user)
        @micropost = FactoryBot.create(:micropost, user_id: @user.id)
      end

      it 'マイクロポストを削除できること' do
        log_in_as(@user)
        expect do
          delete :destroy, params: { id: @micropost.id }
        end .to change(@user.microposts, :count).by(-1)
      end
    end

    context '認可されていないユーザーとして' do
      it 'マイクロポストを削除できないこと' do
        log_in_as(user)
        micropost
        expect do
          delete :destroy, params: { id: micropost.id }
        end .to_not change(Micropost, :count)
      end

      it 'ホーム画面にリダイレクトすること' do
        log_in_as(user)
        micropost
        delete :destroy, params: { id: micropost.id }
        expect(response).to redirect_to '/'
      end
    end

    context 'ゲストユーザーとして' do
      it 'マイクロポストを削除できないこと' do
        micropost
        expect do
          delete :destroy, params: { id: micropost.id }
        end .to_not change(Micropost, :count)
      end

      it 'ホーム画面にリダイレクトすること' do
        micropost
        delete :destroy, params: { id: micropost.id }
        expect(response).to redirect_to '/login'
      end
    end
  end
end
