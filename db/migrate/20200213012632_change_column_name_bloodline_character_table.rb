class ChangeColumnNameBloodlineCharacterTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :characters, :bloodline, :bloodline_id
  end
end
