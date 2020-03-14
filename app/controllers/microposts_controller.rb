class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create destroy]
  before_action :correct_user_micropost,   only: :destroy

  def new
    @micropost = Micropost.new
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comment =Comment.new
    @comment_page = Comment.where(micropost_id: @micropost.id)
    @comments = @comment_page.page(params[:page]).per(10)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '投稿しました!'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to request.referer || current_user
  end

  private

  def micropost_params
    params.require(:micropost).permit(:title, :content, :picture)
  end

  def correct_user_micropost
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
