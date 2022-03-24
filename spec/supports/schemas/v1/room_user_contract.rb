module V1
  module RoomUser
    RoomUserSchema = Dry::Schema.Params do
      required(:id).filled(:string)
      required(:type).value(eql?: 'room_user')
      required(:attributes).hash do
        required(:id).filled(:integer)
        required(:start_date).filled(:string)
        required(:end_date).filled(:string)
        required(:user_id).filled(:integer)
        required(:room_id).filled(:integer)
        required(:created_at).filled(:string)
      end
    end
  
    class RoomUserContract < Dry::Validation::Contract
      schema do
        required(:data).hash(RoomUserSchema)
      end
    end
  
    class RoomUserListContract < Dry::Validation::Contract
      schema do
        required(:data).array(RoomUserSchema)
      end
    end
  end
end