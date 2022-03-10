RSpec.describe RoomDetailService do
  let!(:hotel_room) { FactoryBot.create(:room) }
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }
  let!(:user_3) { FactoryBot.create(:user) }
  let!(:room_txn_1) do 
    FactoryBot.create(:room_user_txn, room_id: hotel_room.id, user_id: user_1.id, start_date: "2021-01-01", end_date: "2021-01-10") 
  end
  let!(:room_txn_2) do 
    FactoryBot.create(:room_user_txn, room_id: hotel_room.id, user_id: user_2.id, start_date: "2021-01-11", end_date: "2021-01-15") 
  end
  let!(:room_txn_3) do 
    FactoryBot.create(:room_user_txn, room_id: hotel_room.id, user_id: user_3.id, start_date: "2021-01-17", end_date: "2021-01-22") 
  end

  describe "#perform" do 
    it "does return room data with its transaction history" do
      res = described_class.new(hotel_room).perform

      expect(res.id).to eql hotel_room.id
      expect(res.name).to eql hotel_room.name

      expect(res.history.size).to eql 3
      expect(res.history.first.id).to eql room_txn_1.id
      expect(res.history.first.start_date).to eql room_txn_1.start_date.to_date
      expect(res.history.third.id).to eql room_txn_3.id
      expect(res.history.third.start_date).to eql room_txn_3.start_date.to_date
    end
  end
end