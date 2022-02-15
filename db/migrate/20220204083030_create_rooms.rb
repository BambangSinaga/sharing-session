class CreateRooms < ActiveRecord::Migration[6.1]
  def up
    execute <<-DDL
      CREATE TYPE bed_type_opt AS ENUM (
        '1 king', '1 twin', '2 twin'
      );
    DDL

    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.column :bed_type, :bed_type_opt
      t.boolean :wifi
      t.boolean :breakfast
      t.boolean :ac
      t.boolean :bathroom
      t.boolean :shower
      t.boolean :balkon
      t.integer :guests
      t.integer :room_area
      t.string :slug

      t.timestamps
    end
  end

  def down
    drop_table :rooms
    execute "DROP type bed_type_opt;"
  end
end
