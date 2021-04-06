class ToppagesController < ApplicationController
  include SubjectsHelper
  
  #トップページ（全て）
  def index
    @novels = Novel.order(updated_at: :desc).page(params[:page]).per(25)
  end
  
  #トップページ（今週）
  def this_week
    novels = Novel.order(updated_at: :desc).page(params[:page]).per(25)
    @novels = []
    novels.each do |novel|
      if in_period?(novel)
        @novels.push(novel)
      end
    end
  end
  
  #トップページ（先週）
  def one_week_ago
    novels = Novel.order(updated_at: :desc).page(params[:page]).per(25)
    @novels = []
    novels.each do |novel|
      if one_week_ago?(novel)
        @novels.push(novel)
      end
    end
  end
  
  #トップページ（先々週）
  def two_weeks_ago
    novels = Novel.order(updated_at: :desc).page(params[:page]).per(25)
    @novels = []
    novels.each do |novel|
      if two_weeks_ago?(novel)
        @novels.push(novel)
      end
    end
  end
end
