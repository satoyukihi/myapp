class FollowRelationshipsController < ApplicationController
 
  def create
    @user =User.find(params[:follow_relationship][:following_id])
    current_user.follow(@user)
  end
  
  def destroy
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.unfollow(@user)
  end
end