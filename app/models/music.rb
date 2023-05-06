class Music < ApplicationRecord
  belongs_to :user
  belongs_to :music_genre
  has_many :music_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_one_attached :music_image
  
  validates :music_name ,presence: true,
    length: { minimum: 1, maximum: 20 }
  validates :singer ,presence: true,
    length: { minimum: 1, maximum: 20 }
    
   def favorited_by?(user)
    favorites.exists?(user_id: user.id)
   end
   
   def get_image(width, height)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attached(io: File.open(file_path),filename: 'default-image.jpg',content_type: 'image/jpeg')
      end
      image.variant( gravity: :center, resize:"#{width} x #{height}^", crop:"#{width} x #{height}+0+0")
   end
end
