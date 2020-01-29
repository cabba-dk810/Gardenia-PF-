# frozen_string_literal: true

class CreateSearchPlants < ActiveRecord::Migration[5.2]
  def change
    create_table :search_plants do |t|
      t.string :plant_image_id

      t.timestamps
    end
  end
end
