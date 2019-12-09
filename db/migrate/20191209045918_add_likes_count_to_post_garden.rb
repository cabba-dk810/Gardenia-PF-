class AddLikesCountToPostGarden < ActiveRecord::Migration[5.2]
  def change
    add_column :post_gardens, :likes_count, :integer
  end
end
