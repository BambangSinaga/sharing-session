module Api::V1
  class RoomsController < ApplicationController
    include Requests::RoomRequest

    def index
      rooms = Room.all
      render json: rooms.to_json, status: :ok
    end

    def create
      room = Room.new(room_params)
      if room.save
        render json: room.to_json, status: :created
      else
        render json: room.errors.messages.to_json, status: :unprocessable_entity
      end
    end

    def show
      room = Room.find(params[:id])

      render json: ::V1::RoomSerializer[room].serializable_hash, status: :ok
    end

    def booking
      booking_params

      room = ::BookingForm.new(room(params[:room_id]), booking_params, user_params)

      if room.save
        render json: room.to_json, status: :created
      else 
        render json: room.errors.messages.to_json, status: :unprocessable_entity
      end
    end

    def show
      response = ::RoomDetailService.new(room(params[:id])).perform

      render json: response.to_json, status: :ok
    end

    private

    def room_params
      params.permit(:name)
    end

    def booking_params
      params.permit(:room_id, :start_date, :end_date)
    end

    def user_params
      params.permit(:name, :email, :phone)
    end

    def room(id)
      Room.find(id)
    end
  end
end
