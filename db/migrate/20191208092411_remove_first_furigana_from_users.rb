class RemoveFirstFuriganaFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_furigana, :string
  end
end
