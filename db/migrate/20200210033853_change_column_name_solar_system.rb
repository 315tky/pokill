class ChangeColumnNameSolarSystem < ActiveRecord::Migration[6.0]
  def change
    rename_column :solarsystems, :system_id, :solar_system_id
  end
end
