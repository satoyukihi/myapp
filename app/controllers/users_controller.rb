class UsersController < ApplicationController
  def new
    #新規ユーザ登録ページ
    @user =User.new#フォームからcreateにデーターを渡す
  end
  
  def create
    #データーを受け取る
    #データーベースにセーブ
    #フラッシュ
    #リダイレクトホームページ
    #失敗
    #もう一度　render new
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Myごはんへようこそ"
      redirect_to root_url
    else
     render 'new'
    end
  end
  
  def show
    @user =User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
  end
  
  def index
  end
  
  #クラス内で参照
 private

    def user_params#ストロングパラメーター設定
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
  
end
