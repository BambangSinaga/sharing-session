class CreateRoomUserTxns < ActiveRecord::Migration[6.1]
  def change
    create_table :room_user_txns do |t|
      t.date :start_date
      t.date :end_date
      t.bigint :user_id
      t.bigint :room_id

      t.timestamps
    end
  end
end
