class CreatePlantedGardens < ActiveRecord::Migration[5.2]
  def change
    create_table :planted_gardens do |t|
    	t.integer :post_garden_id
    	t.string :plant_name
    	t.integer :plant_number

      t.timestamps
    end
  end
end
