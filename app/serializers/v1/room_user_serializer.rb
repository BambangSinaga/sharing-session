module V1
  class RoomUserSerializer
    include JSONAPI::Serializer

    belongs_to :room, serializer: ::V1::RoomSerializer,
               links: { 
                 self: -> (object) {
                  "https://localhost:3000/api/v1/rooms/#{object.room.id}"
                }
               }

    belongs_to :user, serializer: ::V1::UserSerializer

    attributes :id, :start_date, :end_date, :user_id, :room_id, :created_at
  end
end