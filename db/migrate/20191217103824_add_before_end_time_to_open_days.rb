class AddBeforeEndTimeToOpenDays < ActiveRecord::Migration[5.2]
  def change
    add_column :open_days, :before_end_time, :datetime
  end
end
