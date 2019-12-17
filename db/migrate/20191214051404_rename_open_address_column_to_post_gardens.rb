class RenameOpenAddressColumnToPostGardens < ActiveRecord::Migration[5.2]
  def change
  	rename_column :post_gardens, :open_address, :address
  end
end
