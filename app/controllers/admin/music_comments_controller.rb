class Admin::MusicCommentsController < ApplicationController
    before_action :authenticate_admin!
  
  def destroy
    @music_comment = MusicComment.find(params[:id])
    @music_comment.destroy
    redirect_to admin_music_path(@music_comment.music.id),flash: {notice: "コメントが削除されました"}
  end
  
end
