class MicropostsController < ApplicationController
  include CommentActions
  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :correct_user_micropost, only: %i[edit uppdate destroy]

  def new
    @micropost = Micropost.new
  end

  def show
    comments_get
    @comment = Comment.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    tag_list = params[:micropost][:tag_ids].split(',')
    if @micropost.save
      @micropost.save_tags(tag_list)
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

  def edit
    @micropost = Micropost.find(params[:id])
    @tag_list = @micropost.tags.pluck(:name).join(',')
  end

  def update
    @micropost = Micropost.find(params[:id])
    tag_list = params[:micropost][:tag_ids].split(',')
    if @micropost.update(micropost_params)
      if @micropost.save_tags(tag_list)
        flash[:success] = '投稿を編集しました‼'
        redirect_to @micropost
      else
        flash.now[:danger] = '空白のタグが含まれています'
        render 'edit'
      end
    else
      render 'edit'
    end
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
