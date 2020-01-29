# frozen_string_literal: true

class AddOwnerNameToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :owner_name, :string
  end
end
