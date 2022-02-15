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
end
