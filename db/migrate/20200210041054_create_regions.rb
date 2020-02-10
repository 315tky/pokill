class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.text :region_name
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
