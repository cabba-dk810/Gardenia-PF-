class RemoveLastFuriganaFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :last_furigana, :string
  end
end
