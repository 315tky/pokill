class CreateDgmAttributeTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :dgm_attribute_types do |t|
      t.integer :attribute_id
      t.text :attribute_name
      t.text :description
      t.integer :icon_id
      t.decimal :default_value
      t.integer :published
      t.text :display_name
      t.integer :unit_id
      t.integer :stackable
      t.integer :high_is_good
      t.integer :category_id

      t.timestamps
    end
  end
end
