class AddUniqueIndexCharacterTable < ActiveRecord::Migration[6.0]
  def change
    add_index :characters, [:character_id, :name], :unique => true
  end
end
