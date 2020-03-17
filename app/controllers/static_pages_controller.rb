class StaticPagesController < ApplicationController
  def home
    #@microposts = params[:tag_id].present? ? Tag.find(params[:tag_id]).microposts : Micropost.all
    @microposts =  params[:search].present? ? Micropost.micropost_serach(params[:search]) :  Micropost.all
    @microposts = @microposts.page(params[:page]).per(10)
  end
end
