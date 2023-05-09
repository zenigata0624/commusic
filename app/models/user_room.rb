class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :chats
end
