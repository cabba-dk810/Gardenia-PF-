class CreateOpenDays < ActiveRecord::Migration[5.2]
  def change
    create_table :open_days do |t|
    	t.integer :post_garden_id
    	t.time :start_time
    	t.time :end_time

      t.timestamps
    end
  end
end
