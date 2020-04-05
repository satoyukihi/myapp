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
    @tag_ids = params[:micropost][:tag_ids].split(',')
    if @micropost.save
      if @micropost.save_tags(@tag_ids)
        flash[:success] = '投稿しました!'
        redirect_to root_url
      else
        @tag_ids = params[:micropost][:tag_ids]
        flash.now[:danger] = '空白のタグが含まれています'
        render 'new'
      end
    else
      @tag_ids = params[:micropost][:tag_ids]
      render 'new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to current_user || request.referer
  end

  def edit
    @micropost = Micropost.find(params[:id])
    @tag_ids = @micropost.tags.pluck(:name).join(',')
  end

  def update
    @micropost = Micropost.find(params[:id])
    @tag_ids = params[:micropost][:tag_ids].split(',')
    if @micropost.update(micropost_params)
      if @micropost.save_tags(@tag_ids)
        flash[:success] = '投稿を編集しました‼'
        redirect_to @micropost
      else
        @tag_ids = params[:micropost][:tag_ids]
        flash.now[:danger] = '空白のタグが含まれています'
        render 'edit'
      end
    else
      @tag_ids = params[:micropost][:tag_ids]
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
