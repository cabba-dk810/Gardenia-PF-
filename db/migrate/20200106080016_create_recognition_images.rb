# frozen_string_literal: true

class CreateRecognitionImages < ActiveRecord::Migration[5.2]
  def change
    create_table :recognition_images do |t|
      t.integer :search_plant_id
      t.string :recognition_result

      t.timestamps
    end
  end
end
