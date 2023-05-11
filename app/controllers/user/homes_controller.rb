class User::HomesController < ApplicationController
  def top
  end

  def about
     @new_musics = Music.recent.limit(4)
  end
end
