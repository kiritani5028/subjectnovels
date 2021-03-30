class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    novel = Novel.find(params[:novel_id])
    current_user.like(novel)
    flash[:success] = "お気に入りに追加しました。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    novel = Novel.find(params[:novel_id])
    current_user.unlike(novel)
    flash[:success] = "お気に入りから削除しました。"
    redirect_back(fallback_location: root_path)
  end
end
