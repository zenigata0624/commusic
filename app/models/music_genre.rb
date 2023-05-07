class MusicGenre < ApplicationRecord
  has_many :musics,dependent: :destroy
  validates :genre_name, presence: true
end
