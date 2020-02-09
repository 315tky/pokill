class CreateKillmails < ActiveRecord::Migration[6.0]
  def change
    create_table :killmails do |t|
      t.integer :killmail_id
      t.datetime :killmail_time
      t.integer :solar_system_id
      t.integer :victim_corporation_id
      t.integer :victim_damage_taken
      t.jsonb :victim_position

      t.timestamps
    end
  end
end
