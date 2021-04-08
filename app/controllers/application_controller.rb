class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private
  
  #ログインしていないユーザーはトップページへ移動
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  #ユーザー数カウント
  def counts(user)
    @count_favorites = user.like_novel.where(is_draft: false).count
    @count_posts = user.novels.where(is_draft: false).count
    @count_drafts = user.novels.where(is_draft: true).count
  end

end
