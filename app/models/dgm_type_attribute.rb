class DgmTypeAttribute < ApplicationRecord
  belongs_to :item, :foreign_key => "item_type_id", :primary_key => "item_type_id"
  belongs_to :dgm_attribute_type, :foreign_key => "attribute_id", :primary_key => "attribute_id"

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}" # local eve mysql db connection
      ActiveRecord::Base.establish_connection(db_connection.to_sym)
      type_attributes = ActiveRecord::Base.connection.execute("select attributeID,
                                                              typeID,
                                                              valueInt,
                                                              valueFloat
                                                              from dgmTypeAttributes").to_a
      ActiveRecord::Base.connection.close
      for_import = []
      type_attributes.each do |ta|
        ta_hash = { "attribute_id" => ta[0],
                    "item_type_id" => ta[1],
                    "value_int"    => ta[2],
                    "value_float"  => ta[3]
                     }

        for_import.push(ta_hash)
      end
        db_connection = "#{Rails.env}" # std dev or prod postgres db connection
        ActiveRecord::Base.establish_connection(db_connection.to_sym)
        DgmTypeAttribute.import for_import, batch_size: 1000, on_duplicate_key_ignore: true
        ActiveRecord::Base.connection.close
    end
  end
end
