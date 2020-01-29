# frozen_string_literal: true

class RemoveBeforeEndTimeFromOpenDays < ActiveRecord::Migration[5.2]
  def change
    remove_column :open_days, :before_end_time, :datetime
  end
end
