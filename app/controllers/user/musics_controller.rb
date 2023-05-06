class User::MusicsController < ApplicationController

  before_action :correct_user,only: [:edit,:update,]
  before_action :set_music_genre, only: [:new, :create]
  
  def new
     @music = Music.new
  end

   def create
    @music=Music.new(music_params)
    @music.user_id = current_user.id
   if @music.save
     redirect_to music_path(@music.id),success: "投稿が完了しました"
   else
    @user= current_user
    @musics = Music.page(params[:page])
     render :index
   end
  end

  def index
    @musics= Music.all
    @user = current_user
  end

  def show
    @music = Music.find(params[:id])
    @user = User.find_by(id: @music.user_id)
  end

  def edit
    @music = Music.find(params[:id])
    @user= current_user
  end

  def update
    @music = Music.find(params[:id])
    if @music.update(music_params)
       @music.user_id = current_user.id
      redirect_to music_path(@music.id), success: "投稿の変更がされました"
    else
      render :edit
    end
  end


  def destroy
    music = Music.find(params[:id])
    music.destroy
    redirect_to music_path
  end

  private
  
  
  def set_music_genre
    @music_genres = MusicGenre.all
  end

  def music_params
    params.require(:music).permit(:music_name,:singer,:music_genre_id,:music_notes,:music_image,:genre_name,)
  end

 def correct_user
    @music=Music.find(params[:id])
    @user=@music.user
    redirect_to(books_path) unless @user==current_user
 end
 
end
