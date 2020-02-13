class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.integer :character_id
      t.string :name

      t.timestamps
    end
  end
end
