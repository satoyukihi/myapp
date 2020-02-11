class StaticPagesController < ApplicationController
  
  def home
      #@microposts = Micropost.all.page( params[:page]).per(5)
      @q = Micropost.ransack(params[:q])
      @microposts = @q.result(distindt: true).page( params[:page]).per(5)
  end
end
