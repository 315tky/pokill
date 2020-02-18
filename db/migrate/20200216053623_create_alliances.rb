class CreateAlliances < ActiveRecord::Migration[6.0]
  def change
    create_table :alliances do |t|
      t.integer :alliance_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
