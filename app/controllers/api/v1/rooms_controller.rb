module Api::V1
  class RoomsController < ApplicationController
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

    private

    def room_params
      params.permit(:name)
    end
  end
end
