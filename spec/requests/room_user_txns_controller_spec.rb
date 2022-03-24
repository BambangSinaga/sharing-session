RSpec.describe 'Api::V1::RoomsController', type: :request do
  let!(:room) { FactoryBot.create(:room) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:room_user) do
    FactoryBot.create(:room_user_txn, start_date: '2022-01-01', end_date: '2022-01-30',
                                      user_id: user.id, room_id: room.id)
  end

  describe 'GET api/v1/room_user_txns' do
    before { get api_v1_room_user_txns_path }

    it 'return 200' do
      expect(response).to have_http_status :ok
      response_body = JSON.parse(response.body)

      expect(response).to match_schema(::V1::RoomUser::RoomUserListContract)
    end
  end
end
