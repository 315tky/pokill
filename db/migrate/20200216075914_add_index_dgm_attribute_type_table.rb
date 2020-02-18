class AddIndexDgmAttributeTypeTable < ActiveRecord::Migration[6.0]
  def change
    add_index :dgm_attribute_types, :attribute_id, :unique => true
  end
end
