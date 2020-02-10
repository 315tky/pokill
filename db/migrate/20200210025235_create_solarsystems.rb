class CreateSolarsystems < ActiveRecord::Migration[6.0]
  def change
    create_table :solarsystems do |t|
      t.integer :system_id
      t.text :system_name
      t.integer :sun_type_id
      t.decimal :security
      t.text :security_class
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
