class AddUniqueIndexToIndexTable < ActiveRecord::Migration[6.0]
  def change
    add_index :items, [:item_type_id], :unique => true
  end
end
