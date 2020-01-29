# frozen_string_literal: true

class ChangeDataEndTimeToOpenDay < ActiveRecord::Migration[5.2]
  def change
    change_column :open_days, :end_time, :datetime
  end
end
