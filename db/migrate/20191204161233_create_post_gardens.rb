# frozen_string_literal: true

class CreatePostGardens < ActiveRecord::Migration[5.2]
  def change
    create_table :post_gardens do |t|
      t.integer :user_id
      t.text :post_content
      t.string :place
      t.string :area
      t.integer :price
      t.text :problem
      t.text :solution
      t.integer :open_status, :status, default: 0
      t.string :open_postal_code
      t.integer :open_prefecture, :status
      t.string :open_address
      t.integer :open_max_number
      t.integer :open_entrance_fee
      t.text :open_announce

      t.timestamps
    end
  end
end
