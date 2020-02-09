class CreateKillmailItems < ActiveRecord::Migration[6.0]
  def change
    create_table :killmail_items do |t|
      t.integer :killmail_id
      t.string :item_type_id
      t.integer :flag
      t.integer :quantity_destroyed
      t.integer :quantity_dropped
      t.integer :singleton

      t.timestamps
    end
  end
end
