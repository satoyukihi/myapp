class StaticPagesController < ApplicationController
  def home
       
      @microposts = Micropost.all.page( params[:page]).per(1)
  end
end
