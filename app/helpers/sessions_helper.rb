module SessionsHelper
  
  #sessionメゾットを利用。ブラウザの一時cookiesにアンコウが済みのuser.idを作成
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user#もしsessionにuser.idがあれば@current_userにそのユーザーを取得
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
end
