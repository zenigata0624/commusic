class MusicComment < ApplicationRecord
  belongs_to :user
  belongs_to :music

  validates :comment ,presence: true,
   length: { minimum: 1, maximum: 150}
end
