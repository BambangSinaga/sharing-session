module V1
  class UserSerializer 
    include JSONAPI::Serializer

    attributes :id, :name, :email, :phone, :created_at
  end
end