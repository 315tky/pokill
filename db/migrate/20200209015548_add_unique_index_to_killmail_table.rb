class AddUniqueIndexToKillmailTable < ActiveRecord::Migration[6.0]
  def change
    add_index :killmails, :killmail_id, unique: true
  end
end
