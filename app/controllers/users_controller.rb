class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy likes]
  before_action :correct_user,   only: %i[edit update]
  before_action :correct_user_or_admin_user, only: :destroy
  def new
    # 新規ユーザ登録ページ
    @user = User.new # フォームからcreateにデーターを渡す
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'ユーザー登録完了！Myごはんへようこそ！！'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.includes(:tags, :user, :liked_by)
    @microposts = @microposts.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を編集しました‼'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザーを削除しました'
    redirect_to root_url
  end

  def index; end

  def likes
    @user = User.find(params[:id])
    @microposts = @user.likes.includes(:tags, :user, :liked_by).page(params[:page]).per(5)
    render 'show_like'
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(5)
    render 'show_followings'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(5)
    render 'show_followers'
  end

  # クラス内で参照
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user?
    @user = User.find(params[:id])
    current_user?(@user)
  end

  # 管理者か正しいユーザーか確認
  def correct_user_or_admin_user
    redirect_to(root_url) unless current_user.admin? || correct_user?
  end
end
