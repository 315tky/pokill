class ChangeColumnTypesDgmTables < ActiveRecord::Migration[6.0]
  def change
    remove_column :dgm_attribute_types, :default_value
    add_column :dgm_attribute_types, :default_value, :float
    remove_column :dgm_type_attributes, :value_float
    add_column :dgm_type_attributes, :value_float, :float
  end
end
