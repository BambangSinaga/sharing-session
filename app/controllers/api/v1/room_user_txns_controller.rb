module Api::V1
    class RoomUserTxnsController < ApplicationController
        def index
            trx = RoomUserTxn.includes(:room, :user).all
            
            options = {}
            options[:include] = [:room, :user]
            options[:links] = {
                self: request.original_url
              }
            options[:meta] = {
                author: 'Plue Team'
            }
            options[:json_api] = {
                version: '1.0.0'
            }

            render json: ::V1::RoomUserSerializer.new(trx, options).serializable_hash, status: :ok
        end
    end
end