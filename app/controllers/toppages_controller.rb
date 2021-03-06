class ToppagesController < ApplicationController
  before_action :set_novels, only: [:this_week, :one_week_ago, :two_weeks_ago]
  include SubjectsHelper
  
  #トップページ（全て）
  def index
    @novels = Novel.order(updated_at: :desc).page(params[:page]).per(25)
  end
  
  #トップページ（今週）
  def this_week
    @all_novels.each do |novel|
      if in_period?(novel)
        @novels.push(novel)
      end
    end
  end
  
  #トップページ（先週）
  def one_week_ago
    @all_novels.each do |novel|
      if one_week_ago?(novel)
        @novels.push(novel)
      end
    end
  end
  
  #トップページ（先々週）
  def two_weeks_ago
    @all_novels.each do |novel|
      if two_weeks_ago?(novel)
        @novels.push(novel)
      end
    end
  end
  
  private
  
  def set_novels
    @all_novels = Novel.order(updated_at: :desc).page(params[:page]).per(25)
    @novels = []
  end
end
