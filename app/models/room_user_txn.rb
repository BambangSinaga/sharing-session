class RoomUserTxn < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, presence: true
end
