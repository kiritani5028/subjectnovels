class ToppagesController < ApplicationController
  def index
    @novels = Novel.order(updated_at: :desc).page(params[:page]).per(25)
  end
end
