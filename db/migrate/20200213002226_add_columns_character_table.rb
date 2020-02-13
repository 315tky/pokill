class AddColumnsCharacterTable < ActiveRecord::Migration[6.0]
  def change
   add_column :characters, :alliance_id, :integer
   add_column :characters, :ancestry, :integer
   add_column :characters, :birthday, :datetime
   add_column :characters, :bloodline, :integer
   add_column :characters, :corporation_id, :integer
   add_column :characters, :description, :text
   add_column :characters, :gender, :string
   add_column :characters, :race_id, :integer
   add_column :characters, :security_status, :decimal
   add_column :characters, :title, :text
  end
end
