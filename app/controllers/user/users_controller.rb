class User::UsersController < ApplicationController
    
  def index
    @users = User.all
    @user = current_user
  end

  def show
   if params[:id] == "guest_sign_in"
    @user = User.guest
   else
    @user = User.find(params[:id])
   end
  end
 
  
 
  def edit
  end
  
  def update
   
  end
 
  def followings
  end

  def followers
  end
end
