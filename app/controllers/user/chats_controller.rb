class User::ChatsController < ApplicationController
  
  before_action :following_check, only: [:show,]
  
  def show
    @user = User.find(params[:id])
   if @user.flag
    flash[:error] = "ユーザーが存在しません"
    redirect_to user_path(@user)
   end
    rooms = current_user.user_rooms.pluck(:room_id) 
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms) 
   if user_rooms.nil?
     chat_room = Room.new 
     chat_room.save
     UserRoom.create(user_id: current_user.id, room_id: chat_room.id)
     UserRoom.create(user_id: @user.id, room_id: chat_room.id)
   else
    chat_room = user_rooms.room 
   end
   @chats = chat_room&.chats || []
   @chat = Chat.new(room_id: chat_room.id) unless chat_room.nil?
  end
 
  
  
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end
  
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end
  
 private
  
  def following_check
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to musics_path
    end
  end
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
end
