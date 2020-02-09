class AddUniqueIndexToKillMailItemTable < ActiveRecord::Migration[6.0]
  def change
    add_index :killmail_items, [:flag, :item_type_id, :killmail_id, :quantity_destroyed, :quantity_dropped], unique: true, name: 'killmail_item_unique_index'
  end
end
