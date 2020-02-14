class AddUniqueIndexToRegionTable < ActiveRecord::Migration[6.0]
  def change
    add_index :regions, [:region_id], :unique => true
  end
end
