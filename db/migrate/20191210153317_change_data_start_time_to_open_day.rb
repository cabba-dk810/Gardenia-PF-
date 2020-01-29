# frozen_string_literal: true

class ChangeDataStartTimeToOpenDay < ActiveRecord::Migration[5.2]
  def change
    change_column :open_days, :start_time, :datetime
  end
end
