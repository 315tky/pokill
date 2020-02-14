class AddUniqueIndexToFlagTable < ActiveRecord::Migration[6.0]
  def change
    add_index :flags, [:flag_id], :unique => true
  end
end
