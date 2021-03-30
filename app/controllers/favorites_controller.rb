class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  #お気に入りに追加
  def create
    novel = Novel.find(params[:novel_id])
    current_user.like(novel)
    flash[:success] = "お気に入りに追加しました。"
    redirect_back(fallback_location: root_path)
  end
  
  #お気に入りを解除
  def destroy
    novel = Novel.find(params[:novel_id])
    current_user.unlike(novel)
    flash[:success] = "お気に入りを解除しました。"
    redirect_back(fallback_location: root_path)
  end
end
