class CreateCorporations < ActiveRecord::Migration[6.0]
  def change
    create_table :corporations do |t|
      t.integer :corporation_id
      t.string :name

      t.timestamps
    end
  end
end
