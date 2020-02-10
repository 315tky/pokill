class RemoveColumnFromRegionTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :regions, :constellation_id
  end
end
