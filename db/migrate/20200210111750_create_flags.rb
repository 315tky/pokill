class CreateFlags < ActiveRecord::Migration[6.0]
  def change
    create_table :flags do |t|
      t.integer :flag_id
      t.text :flag_name
      t.text :flag_text
      t.integer :order_id

      t.timestamps
    end
  end
end
