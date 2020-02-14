class Flag < ApplicationRecord

  has_many :killmail_items, :primary_key => "flag_id", :foreign_key => "flag_id"

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}" # local eve mysql db connection
      ActiveRecord::Base.establish_connection(db_connection.to_sym)
      flags = ActiveRecord::Base.connection.execute("select flagID,
                                                     flagName,
                                                     flagText,
                                                     orderID from invFlags").to_a
      ActiveRecord::Base.connection.close
      for_import = []
      flags.each do |flag|
        flag_hash = { "flag_id"   => flag[0],
                      "flag_name" => flag[1],
                      "flag_text" => flag[2],
                      "order_id"  => flag[3] }

        for_import.push(flag_hash)
      end
        db_connection = "#{Rails.env}" # std dev or prod postgres db connection
        ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Flag.import for_import, on_duplicate_key_update: { conflict_target: [:flag_id], columns: [:flag_name, :flag_text, :order_id] }
        ActiveRecord::Base.connection.close
    end
  end
end
