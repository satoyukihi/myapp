class MicropostsController < ApplicationController
  
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def new
    @micropost = Micropost.new
  end
  
  def show
    @microposts = Micropost.find(params[:id])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
      if @micropost.save
        flash[:success] = "投稿しました!"
        redirect_to root_url
      else
        @feed_items = []
        render 'new'
      end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer ||current_user
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:title, :content, :picture)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
