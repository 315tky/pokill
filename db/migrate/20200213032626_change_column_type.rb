class ChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    remove_column :corporations, :shares
    add_column :corporations, :shares, :bigint
  end
end
