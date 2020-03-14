class CommentsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user_comment,   only: :destroy
  
  def create 
    @comment = current_user.comments.build(comment_params)
    @comment.micropost_id = params[:micropost_id]
    if @comment.save
      flash[:success] = 'コメントしました'
      redirect_to @comment.micropost
    else
    @micropost = Micropost.find(params[:micropost_id])
    @comment_page = Comment.where(micropost_id: @micropost.id)
    @comments = @comment_page.page(params[:page]).per(10)
    render template: 'microposts/show'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_to @comment.micropost
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user_comment
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
