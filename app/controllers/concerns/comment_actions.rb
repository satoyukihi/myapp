module CommentActions
  extend ActiveSupport::Concern
  
  def get_comments
    @micropost = Micropost.find(params[:id]||params[:micropost_id])
    @comment_page = Comment.where(micropost_id: @micropost.id)
    @comments = @comment_page.page(params[:page]).per(10)
  end
end