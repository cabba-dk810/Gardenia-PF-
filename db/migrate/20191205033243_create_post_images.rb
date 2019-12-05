class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
    	t.integer :post_garden_id
    	t.text :garden_image_id

      t.timestamps
    end
  end
end
