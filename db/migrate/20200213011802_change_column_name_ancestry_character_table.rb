class ChangeColumnNameAncestryCharacterTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :characters, :ancestry, :ancestry_id
  end
end
