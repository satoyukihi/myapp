class SessionsController < ApplicationController
  def new#ログインページを表示
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
     log_in user
     flash[:success] = "ログイン成功‼"
     redirect_back_or root_path
    end
  end
  
  def destroy#logout
    log_out
    flash[:info] = "ログアウトしました"
    redirect_to root_url
  end
  
  
end
