module SessionsHelper
  #ログインしているユーザーを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #ログインいているか判別
  def logged_in?
    !!current_user
  end
end
