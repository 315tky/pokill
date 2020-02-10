class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :type_id
      t.integer :group_id
      t.text :type_name
      t.text :description
      t.decimal :mass
      t.decimal :volume
      t.decimal :capacity
      t.integer :portionSize
      t.integer :race_id
      t.decimal :base_price
      t.integer :published
      t.integer :market_group_id
      t.integer :icon_id
      t.integer :sound_id
      t.integer :graphic_id

      t.timestamps
    end
  end
end
