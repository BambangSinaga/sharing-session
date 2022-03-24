module V1
  class RoomSerializer
    include JSONAPI::Serializer

    attributes :id, :name, :description, :bed_type, :wifi, :breakfast, :ac, :bathroom,
               :shower, :balkon, :guests, :room_area, :slug, :created_at
  end
end