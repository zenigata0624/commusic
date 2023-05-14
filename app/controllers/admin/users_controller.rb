class Admin::UsersController < ApplicationController

 before_action :authenticate_admin!

  def index
    @users=Kaminari.paginate_array(User.all).page(params[:page]).per(4)
    @user = current_user
    @resource = User.new
  end

  def show
     @user = User.find(params[:id])
     @musics = @user.musics.page(params[:page]).per(5)
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
    redirect_to admin_user_path(@user.id),flash: {notice: "ユーザーを更新しました"}
    else
     flash.now[:notice] = "ユーザーの変更に失敗しました"
     render:edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path,flash: {notice: "ユーザーを削除しました"}
  end

   private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction,:flag)
  end

end
