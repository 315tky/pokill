class AddVictimIdColumnToKillmail < ActiveRecord::Migration[6.0]
  def change
    add_column :killmails, :victim_id, :integer
    add_column :killmails, :victim_ship_id, :integer
  end
end
