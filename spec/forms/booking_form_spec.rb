RSpec.describe ::BookingForm, type: :form do
  let!(:hotel_room) { FactoryBot.create(:room) }
  let(:booking_params) do
    {
      room_id: hotel_room.id,
      start_date: "2021-10-01",
      end_date: "2021-10-11"
    }
  end

  let(:user_params) do
    {
      name: "Rizqi",
      email: "rizq@mail.com",
      phone: "081234345454"
    }
  end

  describe '#save' do
    # valid
    context 'when valid' do
      it "will create user and room transaction" do
        form = described_class.new(hotel_room, booking_params, user_params)

        expect(form).to be_valid
        expect(form.save).to be_truthy

        room_txn = RoomUserTxn.all

        expect(room_txn.size).to eql 1
        expect(room_txn.first.start_date).to eql booking_params[:start_date].to_date
        expect(room_txn.first.end_date).to eql booking_params[:end_date].to_date
      end
    end

    # invalid
    context 'when invalid' do
      let!(:user) do
        FactoryBot.create(:user, name: "jack", email: 'jack@mail.com', phone: '081478789898')
      end 

      let!(:room_user_txn) do
        FactoryBot.create(:room_user_txn, user_id: user.id, room_id: hotel_room.id, start_date: '2021-09-28', end_date: '2021-10-05')
      end 

      it "will create user and room transaction" do
        form = described_class.new(hotel_room, booking_params, user_params)

        expect(form).to be_invalid
        expect(form.save).to be_falsy

        room_txn = RoomUserTxn.all

        expect(room_txn.size).to eql 1

        expect(room_txn.first.user.name).to eql user.name
        expect(room_txn.first.user.email).to eql user.email
        expect(room_txn.first.start_date).to eql room_user_txn.start_date.to_date
        expect(room_txn.first.end_date).to eql room_user_txn.end_date.to_date
      end
    end
  end
end