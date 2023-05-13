class Admin::MusicsController < ApplicationController

   before_action :authenticate_admin!

  def index
     @musics=Kaminari.paginate_array(Music.all).page(params[:page]).per(5)
  end

  def show
    @music = Music.find(params[:id])
    @user = User.find_by(id: @music.user_id)
    @music_comments = @music.music_comments
  end

  def destroy
    music = Music.find(params[:id])
    music.destroy
    redirect_to admin_musics_path
  end


   private

   def music_params
    params.require(:music).permit(:music_name,:singer,:music_genre_id,:music_notes,:music_image,:genre_name,:comment)
   end
end
