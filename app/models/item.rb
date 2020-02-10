class Item < ApplicationRecord

  has_many :killmail_items, :primary_key => "item_type_id", :foreign_key => "item_type_id"

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}"
      connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
      items = connect.connection.execute("select typeID,
                                            groupID,
                                            typeName,
                                            description,
                                            mass,
                                            volume,
                                            capacity,
                                            portionSize,
                                            raceID,
                                            basePrice,
                                            published,
                                            marketGroupID,
                                            iconID,
                                            soundID,
                                            graphicID from invTypes").to_a
      ActiveRecord::Base.connection.close

      items.each do |item|
        for_import = { "item_type_id"    => item[0],
                       "group_id"        => item[1],
                       "type_name"       => item[2],
                       "description"     => item[3],
                       "mass"            => item[4],
                       "volume"          => item[5],
                       "capacity"        => item[6],
                       "portion_size"    => item[7],
                       "race_id"         => item[8],
                       "base_price"      => item[9],
                       "published"       => item[10],
                       "market_group_id" => item[11],
                       "icon_id"         => item[12],
                       "sound_id"        => item[13],
                       "graphic_id"      => item[14]
                     }
        db_connection = "#{Rails.env}"
        connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Item.find_or_create_by(for_import)
        ActiveRecord::Base.connection.close
      end
    end
  end
end
