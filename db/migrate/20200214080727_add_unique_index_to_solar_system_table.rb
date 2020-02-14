class AddUniqueIndexToSolarSystemTable < ActiveRecord::Migration[6.0]
  def change
    add_index :solarsystems, [:solar_system_id], :unique => true
  end
end
