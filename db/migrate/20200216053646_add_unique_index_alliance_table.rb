class AddUniqueIndexAllianceTable < ActiveRecord::Migration[6.0]
  def change
    add_index :alliances, [:name, :alliance_id], :unique => true
  end
end
