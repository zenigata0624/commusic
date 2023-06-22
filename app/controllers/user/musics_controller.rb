class User::MusicsController < ApplicationController

  before_action :correct_user,only: [:edit,:update,:destroy]
  before_action :set_music_genre, only: [:new, :create]

  def new
     @music = Music.new
  end

  #guestユーザーに対する条件分岐と投稿に関する条件分岐です
  def create
   if current_user.nil? || current_user.guest?
     redirect_to  musics_path, flash: { notice: "ゲストユーザーは投稿できません。" }
   else
     @music=Music.new(music_params)
     @music.user_id = current_user.id
     @music_genres = MusicGenre.all
    if @music.save
     redirect_to music_path(@music.id), flash: {notice: "投稿が完了しました"}
    else
     flash.now[:notice] = @music.errors.full_messages.join(', ')
     @user= current_user
     @musics = Music.page(params[:page])
     @q = Music.ransack(params[:q])
     render :new
    end
   end
  end


 #ジャンルと検索の条件分岐を行っています
  def index
    @music_genres = MusicGenre.all
    @q = Music.ransack(params[:q])
    @music_search = @q.result(distinct: true)
   if params[:music_genre_id].present?
    @music_genre = MusicGenre.find(params[:music_genre_id])
    @musics = Kaminari.paginate_array(@music_genre.musics).page(params[:page]).per(6)
    flash.now[:notice] = "ジャンルが表示されました"
   else
    @musics = Kaminari.paginate_array(@music_search).page(params[:page]).per(6)
   end
  end


  #ViewCountの記述は閲覧数に関する記述です
  def show
   @music = Music.find(params[:id])
   @user = User.find_by(id: @music.user_id)
   @music_comment = MusicComment.new
   @music_comments = @music.music_comments.order(created_at: :desc).page(params[:page]).per(3)
   unless ViewCount.find_by(user_id: current_user.id, music_id: @music.id)
    current_user.view_counts.create(music_id: @music.id)
   end
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
      redirect_to music_path(@music.id),flash: {notice: "投稿の変更がされました"}
    else
       @user = current_user
       @music_genres = MusicGenre.all
       flash.now[:notice] = @music.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    music = Music.find(params[:id])
    music.destroy
    redirect_to musics_path,flash: {notice: "投稿を削除しました"}
  end


  def search
   if params[:q].nil? || params[:q][:music_name_cont].blank?
    redirect_to musics_path,flash: {notice: "検索に記入がありませんでした"}
   else
    @q = Music.ransack(params[:q])
    @musics = @q.result(distinct: true).page(params[:page]).per(5)
    flash.now[:notice] = "検索結果が表示されました"
    render :search_results
   end
  end

  private


  def set_music_genre
    @music_genres = MusicGenre.all
  end

  def music_params
    params.require(:music).permit(:music_name,:singer,:music_genre_id,:music_notes,:music_image,:genre_name)
  end

 #ログインユーザー以外のアクセス制限をしております
 def correct_user
    @music=Music.find(params[:id])
    @user=@music.user
    redirect_to(musics_path) unless @user==current_user
 end

end
