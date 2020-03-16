class StaticPagesController < ApplicationController
  def home
    # @microposts = Micropost.all.page( params[:page]).per(5)
    #@q = Micropost.ransack(params[:q])
    @microposts = params[:tag_id].present? ? Tag.find(params[:tag_id]).microposts : Micropost.all
    #@microposts = @q.result(distindt: true).page(params[:page]).per(5)
    @microposts = @microposts.page(params[:page]).per(10)
  end
end
