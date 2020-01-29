# frozen_string_literal: true

class AddOwnerIdToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :owner_id, :integer
  end
end
