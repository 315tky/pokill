class AddUniqueIndexToKillMailAttackerTable < ActiveRecord::Migration[6.0]
  def change
    add_index :killmail_attackers, [:killmail_id, :attacker_id], :unique => true
  end
end
