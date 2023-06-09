class Admin::MusicGenresController < ApplicationController

  before_action :authenticate_admin!

  def index
    @musics=Music.all
    @music_genres = MusicGenre.all
    @music = MusicGenre.find(params[:music_genre_id]).music if params[:music_genre_id].present?
    @music_genre = MusicGenre.new
  end

  def create
     @music_genre = MusicGenre.new(music_genre_params)
   if @music_genre.save
     redirect_to admin_music_genres_path, flash: {notice: "ジャンルが投稿されました"}
   else
     redirect_back(fallback_location: admin_music_genres_path, flash: {notice: "記述がないため失敗しました"})
   end
  end

  def edit
    @music_genre = MusicGenre.find(params[:id])
  end

  def update
       @music_genre = MusicGenre.find(params[:id])
    if @music_genre.update(music_genre_params)
       redirect_to admin_music_genres_path,flash: {notice: "ジャンルの変更がされました"}
    else
      flash.now[:notice] = "ジャンルの変更に失敗しました"
      render :edit
    end
  end

  def destroy
    @music_genre = MusicGenre.find(params[:id])
    @music_genre.destroy
     redirect_to admin_music_genres_path,flash: {notice: "ジャンルが削除されました"}
  end

  private

  def music_genre_params
    params.require(:music_genre).permit(:genre_name)
  end

end
