class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :correct_user, only: [:destroy, :show, :favorites, :drafts]
  include SubjectsHelper
  
  #ユーザー詳細ページ（投稿した小説一覧）
  def show
    @novels = current_user.novels.order(id: :desc).page(params[:page]).per(25)
    counts(@user)
  end
  
  #ユーザー詳細ページ（お気に入りに追加した作品）
  def favorites
    @novels = current_user.like_novel.order(id: :desc).page(params[:page]).per(25)
    counts(@user)
  end
  
  #ユーザー詳細ページ（下書き一覧）
  def drafts
    @novels = current_user.novels.order(id: :desc).page(params[:page]).per(25)
    counts(@user)
  end
  
  #ユーザー新規登録ページ
  def new
    @user = User.new
  end
  
  #ユーザーを作成
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  #ユーザを削除
  def destroy
    @user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to root_url
  end
  
  private
  
  #ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  #ログインしているユーザーか判定
  def correct_user
    @user = current_user
    unless @user
      redirect_to root_url
    end
  end
end
