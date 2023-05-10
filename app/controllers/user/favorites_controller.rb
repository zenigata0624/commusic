class User::FavoritesController < ApplicationController
  before_action :authenticate_user!

 def create
  if current_user.guest?
    redirect_to root_path, alert: 'ゲストユーザーはいいねをつけることができません。'
  else
   @music = Music.find(params[:music_id])
    favorite = current_user.favorites.new(music_id: @music.id)
    favorite.save
  end
 end

 def destroy
   @music = Music.find(params[:music_id])
    favorite = current_user.favorites.find_by(music_id: @music.id)
    favorite.destroy
 end

 def index
   @favorites = current_user.favorites.page(params[:page]).per(10)
 end


end
