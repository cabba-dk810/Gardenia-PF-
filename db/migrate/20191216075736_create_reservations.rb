# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :post_garden_id
      t.datetime :r_start_datetime
      t.datetime :r_end_datetime
      t.string :reservation_name
      t.integer :reservation_num
      t.text :reservation_message
      t.string :postal_code
      t.string :reservation_address
      t.integer :entrance_fee
      t.text :announce

      t.timestamps
    end
  end
end
