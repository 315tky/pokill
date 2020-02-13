class AddUniqueIndexCorporationTable < ActiveRecord::Migration[6.0]
  def change
    add_index :corporations, [:corporation_id, :name], :unique => true
  end
end
