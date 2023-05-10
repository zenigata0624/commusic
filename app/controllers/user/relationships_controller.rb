class User::RelationshipsController < ApplicationController
  
  before_action :authenticate_user!

 def create
  if current_user.guest?
    redirect_to root_path, flash:{alert: 'ゲストユーザーはフォローすることができません。'}
  else
   current_user.follow(params[:user_id])
    redirect_to request.referer
  end
 end

 def destroy
  current_user.unfollow(params[:user_id])
   redirect_to request.referer
 end

 def followings
  user = User.find(params[:user_id])
   @users = user.followings
 end

 def followres
  user = User.find(params[:user_id])
  @users = user.followers
 end

end
