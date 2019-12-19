class AddCancelReasonToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :cancel_reason, :text
  end
end
