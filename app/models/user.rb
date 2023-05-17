class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :musics, dependent: :destroy
         has_many :music_comments, dependent: :destroy
         has_many :view_counts, dependent: :destroy

         has_many :favorites, dependent: :destroy
         has_many :relationships,class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :reverse_relationships,class_name: "Relationship",foreign_key: "followed_id", dependent: :destroy
         has_many :followings, through: :relationships,source: :followed
         has_many :followers,through: :reverse_relationships, source: :follower

         has_many :user_rooms
         has_many :rooms,through: :user_rooms
         has_many :chats


         has_one_attached :profile_image

         validates :name, uniqueness: true
         validates :name, length: { in: 1..20 }
         validates :introduction ,length: { maximum: 100 }


   def self.guest
     find_or_create_by!(name: 'guest',email: 'guest@example.com') do |user|
     user.password = SecureRandom.urlsafe_base64(10)
     user.name = "guest"
    end
   end

   def guest?
    email == 'guest@example.com'
   end

   def active_for_authentication?
    super && (flag == false)
   end

   def follow(user_id)
    relationships.create(followed_id: user_id)
   end

   def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
   end

   def following?(user)
    followings.include?(user)
   end

   def get_profile_image(width, height)
    unless profile_image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     profile_image.variant( gravity: :center, resize:"#{width} x #{height}^", crop:"#{width} x #{height}+0+0")
   end

end
