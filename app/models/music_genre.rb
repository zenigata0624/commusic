class MusicGenre < ApplicationRecord
  has_many :musics
  validates :genre_name, presence: true
end
