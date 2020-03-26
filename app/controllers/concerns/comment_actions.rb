module CommentActions
  extend ActiveSupport::Concern

  def comments_get
    @micropost = Micropost.find(params[:id] || params[:micropost_id])
    @comment_page = @micropost.comments.includes(:user)
    @comments = @comment_page.page(params[:page]).per(10)
  end
end
