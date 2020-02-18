class AddUniqueIndexDgmTypeAttributeTable < ActiveRecord::Migration[6.0]
  def change
    add_index :dgm_type_attributes, [:item_type_id, :attribute_id], :unique => true
  end
end
