class ChangeColumnsAllianceTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :alliances, :description
    add_column :alliances, :date_founded, :datetime
    add_column :alliances, :creator_corporation_id, :integer
    add_column :alliances, :creator_id, :integer
    add_column :alliances, :executor_corporation_id, :integer
    add_column :alliances, :ticker, :string
    
  end
end
