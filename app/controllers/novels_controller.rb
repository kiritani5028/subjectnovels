class NovelsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  include SubjectsHelper
  
  #小説閲覧ページ
  def show
    @novel = Novel.find(params[:id])
    if @novel.is_draft
      redirect_to user_url(@novel.user)
    end
    
    @subjects = @novel.link_subject
  end
  
  #小説新規作成ページ
  def new
    @novel = Novel.new
  end
  
  #小説の保存
  def create
    @novel = current_user.novels.build(novel_params)
    
    if @novel.save
      #今週のお題であるSubjectモデル３つを紐付ける
      subjects = Subject.last(3)
      subjects.each do |subject|
        @novel.connect(subject)
      end
      
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
  
  #小説編集ページ
  def edit
    if !in_period?(@novel)
      flash[:danger] = "期間外の作品の編集はできません。"
      redirect_to root_url
    end
  end
  
  #小説上書き保存
  def update
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
  
  #小説の削除
  def destroy
    @novel.destroy
    flash[:success] = "小説を削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  #ストロングパラメータ
  def novel_params
    params.require(:novel).permit(:title, :text, :is_draft)
  end
  
  #取得しようとしている小説がログインしているユーザーのものか判別
  def correct_user
    @novel = current_user.novels.find_by(id: params[:id])
    unless @novel
      redirect_to root_url
    end
  end
end
