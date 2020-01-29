# frozen_string_literal: true

class AddColumnToRecognitionImage < ActiveRecord::Migration[5.2]
  def change
    add_column :recognition_images, :rate, :float
  end
end
