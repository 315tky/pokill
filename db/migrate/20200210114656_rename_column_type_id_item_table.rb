class RenameColumnTypeIdItemTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :type_id, :item_type_id
  end
end
