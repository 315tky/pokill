class Item < ApplicationRecord

  has_many :killmail_items, :foreign_key => "item_type_id", :primary_key => "item_type_id"

  has_many :dgm_type_attributes, :foreign_key => "item_type_id", :primary_key => "item_type_id"
  has_many :dgm_attribute_types, :through => :dgm_type_attributes

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}"
      ActiveRecord::Base.establish_connection(db_connection.to_sym)
      items = ActiveRecord::Base.connection.execute("select typeID,
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
      for_import = []
      items.each do |item|
        items_hash = { "item_type_id"    => item[0],
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
          for_import.push(items_hash)
      end
        db_connection = "#{Rails.env}"
        connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Item.import for_import, batch_size: 1000, on_duplicate_key_update: { conflict_target: [:item_type_id],
                                                          columns: [:group_id,
                                                                    :type_name,
                                                                    :description,
                                                                    :mass,
                                                                    :volume,
                                                                    :capacity,
                                                                    :portion_size,
                                                                    :race_id,
                                                                    :base_price,
                                                                    :published,
                                                                    :market_group_id,
                                                                    :icon_id,
                                                                    :sound_id,
                                                                    :graphic_id ] }

        ActiveRecord::Base.connection.close
    end
  end
end
