class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :likes]
  before_action :correct_user,   only: [:edit, :update]
  before_action :testadmin,     only: :destroy
  
  def new
    #新規ユーザ登録ページ
    @user =User.new#フォームからcreateにデーターを渡す
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録完了！Myごはんへようこそ！！"
      redirect_to root_url
    else
     render 'new'
    end
  end
  
  def show
    @user =User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(5)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を編集しました‼"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to root_url
  end
  
  def index
  end
  
  def likes
    
    @user  = User.find(params[:id])
    @microposts = @user.likes.page(params[:page]).per(5)
    render 'show_like'
  end

  
  #クラス内で参照
 private

    def user_params#ストロングパラメーター設定
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user#管理者確認
      redirect_to(root_url) unless current_user.admin?
    end
    
    def correct_user?
      @user = User.find(params[:id])
      current_user?(@user)
    end
    
    def testadmin
      redirect_to(root_url) unless current_user.admin? || correct_user?
    end
end
