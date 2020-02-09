class CreateKillmailAttackers < ActiveRecord::Migration[6.0]
  def change
    create_table :killmail_attackers do |t|
      t.integer :killmail_id
      t.integer :attacker_id
      t.integer :corporation_id
      t.integer :alliance_id
      t.integer :damage_done
      t.boolean :final_blow
      t.integer :security_status
      t.integer :ship_type_id
      t.integer :weapon_type_id

      t.timestamps
    end
  end
end
