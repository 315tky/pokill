class CreateDgmTypeAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :dgm_type_attributes do |t|
      t.integer :item_type_id
      t.integer :attribute_id
      t.integer :value_int
      t.decimal :value_float

      t.timestamps
    end
  end
end
