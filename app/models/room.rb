class Room < ApplicationRecord
  has_many :room_user_txn
  
  validates :name, presence: true
end