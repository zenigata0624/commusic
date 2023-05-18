class User::HomesController < ApplicationController
  def top
  end

 #新着楽曲の表示数を記述しています
  def about
     @new_musics = Music.recent.limit(3)
  end
end
