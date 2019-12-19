class RemoveBeforeStartTimeFromOpenDays < ActiveRecord::Migration[5.2]
  def change
    remove_column :open_days, :before_start_time, :datetime
  end
end
