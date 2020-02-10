class Flag < ApplicationRecord

  has_many :killmail_items, :primary_key => "flag_id", :foreign_key => "flag_id"

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}"
      connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
      flags = connect.connection.execute("select flagID,
                                          flagName,
                                          flagText,
                                          orderID from invFlags").to_a
      ActiveRecord::Base.connection.close

      flags.each do |flag|
        for_import = { "flag_id"   => flag[0],
                       "flag_name" => flag[1],
                       "flag_text" => flag[2],
                       "order_id"  => flag[3] }
        db_connection = "#{Rails.env}"
        connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Flag.find_or_create_by(for_import)
        ActiveRecord::Base.connection.close
      end
    end
  end
end
