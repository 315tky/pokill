class AddColumnsCorporationTable < ActiveRecord::Migration[6.0]
  def change
    add_column :corporations, :alliance_id, :integer
    add_column :corporations, :ceo_id, :integer
    add_column :corporations, :creator_id, :integer
    add_column :corporations, :date_founded, :datetime
    add_column :corporations, :description, :text
    add_column :corporations, :home_station_id, :integer
    add_column :corporations, :member_count, :integer
    add_column :corporations, :shares, :integer
    add_column :corporations, :ticker, :string
    add_column :corporations, :url, :string
    add_column :corporations, :war_eligible, :boolean
  end
end
