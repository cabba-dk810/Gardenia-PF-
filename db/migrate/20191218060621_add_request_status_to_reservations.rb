class AddRequestStatusToReservations < ActiveRecord::Migration[5.2]
  def change
  	add_column :reservations, :request_status, :integer, default: 0
  end
end
