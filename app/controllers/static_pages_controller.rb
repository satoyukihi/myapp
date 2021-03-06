class StaticPagesController < ApplicationController
  def home
    @microposts = if params[:tag_id].present?
                    Tag.find(params[:tag_id]).microposts
                  elsif params[:search].present?
                    Micropost.micropost_serach(params[:search]).includes(:tags, :user, :liked_by)
                  else
                    Micropost.includes(:tags, :user, :liked_by).all
                  end
    @microposts = @microposts.page(params[:page]).per(10)
  end
end
