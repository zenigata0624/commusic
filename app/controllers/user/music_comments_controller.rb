class User::MusicCommentsController < ApplicationController


 def create
  @music = Music.find(params[:music_id])
  if current_user.nil? || current_user.guest?
    redirect_to music_path(@music.id),flash: {notice: 'コメントを投稿するにはログインしてください。'}
  else
    comment = current_user.music_comments.new(music_comment_params)
    comment.music_id = @music.id
   if comment.save
    redirect_to music_path(@music.id) ,flash: {notice: 'コメントの投稿に成功しました'}
   else
    flash[:notice] = comment.errors.full_messages.join(', ')
    redirect_to music_path(@music.id)
   end
  end
 end

  def destroy
   @music= Music.find(params[:music_id])
   @music_comment= MusicComment.find(params[:id])
   @music_comment.destroy
   redirect_to music_path(@music.id),flash: {notice: 'コメントを削除しました'}
  end

  private

  def  music_comment_params
    params.require(:music_comment).permit(:comment)
  end

end