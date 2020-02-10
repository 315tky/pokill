class ChangeColumnNameItemTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :portionSize, :portion_size
  end
end
