class User < ApplicationRecord
  has_one :room_user_txn

  validates :name, :email, presence: true
end
