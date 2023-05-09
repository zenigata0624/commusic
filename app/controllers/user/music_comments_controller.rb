class User::MusicCommentsController < ApplicationController

 def create
  @music = Music.find(params[:music_id])
  if current_user.nil? || current_user.guest?
    redirect_to music_path(@music.id), alert: 'コメントを投稿するにはログインしてください。'
  else
    comment = current_user.music_comments.new(music_comment_params)
    comment.music_id = @music.id
    comment.save
    redirect_to music_path(@music.id), notice: 'コメントを投稿しました。'
  end
 end

  def destroy
   @music= Music.find(params[:music_id])
   @music_comment= MusicComment.find(params[:id])
   @music_comment.destroy
   @music_comment = MusicComment.new
   redirect_to music_path(@music.id)
  end

  private

  def  music_comment_params
    params.require(:music_comment).permit(:comment)
  end

end