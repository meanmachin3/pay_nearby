class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :room_type
      t.integer :user_id
      t.integer :room_id
      t.date :start_date
      t.date :last_date

      t.timestamps
    end
  end
end
