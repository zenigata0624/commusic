class Music < ApplicationRecord


  belongs_to :user
  belongs_to :music_genre
  has_many :view_counts, dependent: :destroy
  has_many :music_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  scope :recent, -> { order(created_at: :desc) }
  default_scope -> { order(created_at: :desc) }
  has_one_attached :music_image

  validates :music_name, uniqueness: { scope: :singer }
  validates :music_name ,presence: true,
    length: { minimum: 1, maximum: 20 }
  validates :singer ,presence: true,
    length: { minimum: 1, maximum: 20 }
  validates :music_notes ,presence: true,
    length: { minimum: 1, maximum: 150 }


  #いいねの有無を確認する記述です
   def favorited_by?(user)
    favorites.exists?(user_id: user.id)
   end


  #画像が添付されていない場合はデフォルト画像を表示し、指定したサイズでリサイズします
   def get_music_image(width, height)
      unless music_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        music_image.attach(io: File.open(file_path),filename: 'default-image.jpg',content_type: 'image/jpeg')
      end
       music_image.variant( gravity: :center, resize:"#{width} x #{height}^", crop:"#{width} x #{height}+0+0")
   end

  #検索機能の記述です
   def self.ransackable_attributes(auth_object = nil)
    column_names
   end

end
