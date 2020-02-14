class AddUniqueIndexToConstellatioTable < ActiveRecord::Migration[6.0]
  def change
    add_index :constellations, [:region_id, :constellation_id], :unique => true
  end
end
