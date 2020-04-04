module NotificationsHelper
  
  def notification_form(notification)
      @visitor = notification.visitor
      @comment = nil
      
      @visitor_comment = notification.comment_id
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "follow" then
          tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
        when "like" then
          tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:micropost_path(notification.micropost_id), style:"font-weight: bold;")+"にいいねしました"
        when "comment" then
            @comment = Comment.find_by(id: @visitor_comment)&.content
            tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:micropost_path(notification.micropost_id), style:"font-weight: bold;")+"にコメントしました"
      end
  end
end
