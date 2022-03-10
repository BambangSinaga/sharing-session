# frozen_string_literal: true

module Requests
  module RoomRequest
    private

    def booking_params
      param! :start_date, Date, required: true
      param! :end_date, Date, required: true
      param! :name, String, required: true
      param! :email, String, required: true
      param! :room_id, Integer, required: true
    end
  end
end
