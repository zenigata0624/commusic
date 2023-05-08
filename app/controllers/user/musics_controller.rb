class User::MusicsController < ApplicationController

  before_action :correct_user,only: [:edit,:update,]
  before_action :set_music_genre, only: [:new, :create]

  def new
     @music = Music.new
  end

  def create
   if current_user.nil? || current_user.guest?
     redirect_to  musics_path, alert: "ゲストユーザーは投稿できません。"
   else
     @music=Music.new(music_params)
     @music.user_id = current_user.id
     @music_genres = MusicGenre.all
    if @music.save
     redirect_to music_path(@music.id),success: "投稿が完了しました"
    else
     @user= current_user
     @musics = Music.page(params[:page])
     render :index
    end
   end
  end
  
  def index
   if current_user.nil? || current_user.guest?
    @musics=Kaminari.paginate_array(Music.all).page(params[:page]).per(10)
   else
    @musics=Kaminari.paginate_array(current_user.musics).page(params[:page]).per(10)
   end
    @user = current_user
  end

  def show
    @music = Music.find(params[:id])
    @user = User.find_by(id: @music.user_id)
    @music_comment = MusicComment.new
  end

  def edit
    @music = Music.find(params[:id])
    @user= current_user
    @music_genres = MusicGenre.all
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
    redirect_to musics_path
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
    redirect_to(musis_path) unless @user==current_user
 end

end
