RSpec.describe 'Api::V1::RoomsController', type: :request do
  # initialize test data
  let!(:data) { FactoryBot.create(:room) }

  describe 'GET /api/v1/rooms' do
    # make HTTP get request before each example
    before { get api_v1_rooms_path }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eql 1
    end
  end


  describe 'POST /rooms' do
    before { post api_v1_rooms_path, params: valid_attributes }

    context 'when the request is valid' do
      # valid payload
      let(:valid_attributes) { { name: 'Learn Elm' } }

      it 'creates a todo' do
        expect(response).to have_http_status(201)
        expect(response.body).to include ('Learn Elm')
      end
    end

    context 'when the request is invalid' do
      let(:valid_attributes) { { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
        expect(response.body).to include "\"name\":[\"can't be blank\"]"
      end
    end
  end

  describe 'POST /booking' do
    context 'when valid' do
      let(:booking_params) do
        {
          room_id: data.id,
          name: "Ujang",
          email: "ujang@mekari.com",
          phone: "081223233434",
          start_date: "2021-10-01",
          end_date: "2021-10-11"
        }
      end

      before { post booking_api_v1_rooms_path, params: booking_params }

      it 'returns code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when invalid' do
      let(:invalid_booking_params) do
        {
          room_id: data.id,
          email: "ujang@mekari.com",
          phone: "081223233434",
          start_date: "2021-10-01",
          end_date: "2021-10-11"
        }
      end
      
      before { post booking_api_v1_rooms_path, params: invalid_booking_params }

      it 'returns code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
