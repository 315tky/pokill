class CreateConstellations < ActiveRecord::Migration[6.0]
  def change
    create_table :constellations do |t|
      t.text :constellation_name
      t.integer :region_id
      t.integer :constellation_id
      t.decimal :x_coord
      t.decimal :y_coord
      t.decimal :z_coord
      t.decimal :radius

      t.timestamps
    end
  end
end
