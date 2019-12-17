class AddLatitudeToPostGarden < ActiveRecord::Migration[5.2]
  def change
    add_column :post_gardens, :latitude, :float
  end
end
