class User::UsersController < ApplicationController
  
   before_action :correct_user,only: [:edit,:update]

   
   before_action :set_user, only: [:show, :edit, :update, :followings,:followers]
    
  def index
    @users = User.all
    @user = current_user
  end

  def show
  end
  
 
  def edit
  end
  
  def update
    if  @user.update(user_params)
    redirect_to user_path(@user.id),success: "会員編集を行いました"
    else
     render:edit
    end
  end
 
  def followings
  end

  def followers
  end
  
   private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def correct_user
   @user=User.find(params[:id])
   redirect_to user_path(current_user) unless @user == current_user && !current_user.guest?
  end
  
end
