class NovelsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def show
    @novel = Novel.find(params[:id])
  end
  
  def new
    @novel = Novel.new
  end
  
  def create
    @novel = current_user.novels.build(novel_params)
    if @novel.save
      if @novel.is_draft
        flash[:success] = "小説を下書きに保存しました。"
      else
        flash[:success] = "小説を投稿しました。"
      end
      redirect_to @novel
    else
      flash[:danger] = "小説の保存に失敗しました。"
      render :new
    end
  end
  
  def edit
    @novel = Novel.find(params[:id])
  end

  def update
    @novel = Novel.find(params[:id])
    if @novel.update(novel_params) 
      if @novel.is_draft
        flash[:success] = "編集した小説を下書きに保存しました。"
      else
        flash[:success] = "編集した小説を投稿しました。"
      end
      redirect_to @novel
    else
      flash[:danger] = "小説の保存に失敗しました。"
      render :edit
    end
  end

  def destroy
    @novel.destroy
    flash[:success] = "小説を削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def novel_params
    params.require(:novel).permit(:title, :text, :is_draft)
  end
  
  def correct_user
    @novel = current_user.novels.find_by(id: params[:id])
    unless @novel
      redirect_to root_url
    end
  end
end
