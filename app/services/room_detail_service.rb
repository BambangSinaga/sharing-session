class RoomDetailService
  Response = Struct.new(:id, :name, :description, :bed_type, :wifi, :breakfast, :ac, 
                        :bathroom, :shower, :balkon, :guests, :room_area, :slug, :history)
  def initialize(room)
    @room = room
  end

  def perform
    build_response
  end

  private

  def build_response
    room = Response.new

    room.id = @room.id
    room.name = @room.name
    room.description = @room.description
    room.bed_type = @room.bed_type
    room.wifi = @room.wifi
    room.breakfast = @room.breakfast
    room.ac = @room.ac
    room.bathroom = @room.bathroom
    room.shower = @room.shower
    room.guests = @room.guests
    room.room_area = @room.room_area
    room.slug = @room.slug
    room.history = @room.room_user_txn

    room
  end
end