class RemoveBogusIndexOnCharacterTable < ActiveRecord::Migration[6.0]
  def change
    remove_index :characters, name: "index_characters_on_character_id"
  end
end
