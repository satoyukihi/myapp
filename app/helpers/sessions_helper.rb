module SessionsHelper
  
  #sessionメゾットを利用。ブラウザの一時cookiesにuser.idを保存
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user#もしsessionにuser.idがあれば@current_userにそのユーザーを取得
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
  
end
