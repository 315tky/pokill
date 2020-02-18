class DgmAttributeType < ApplicationRecord

  has_many :dgm_type_attributes, :foreign_key => "attribute_id", :primary_key => "attribute_id"
  has_many :items, :through => :dgm_type_attributes

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}" # local eve mysql db connection
      ActiveRecord::Base.establish_connection(db_connection.to_sym)
      attribute_types = ActiveRecord::Base.connection.execute("select attributeID,
                                                              attributeName,
                                                              description,
                                                              iconID,
                                                              defaultValue,
                                                              published,
                                                              displayName,
                                                              unitID,
                                                              stackable,
                                                              highIsGood,
                                                              categoryID
                                                              from dgmAttributeTypes").to_a
      ActiveRecord::Base.connection.close
      for_import = []
      attribute_types.each do |at|
        at_hash = { "attribute_id"   => at[0],
                      "attribute_name" => at[1],
                      "description"    => at[2],
                      "icon_id"        => at[3],
                      "default_value"  => at[4],
                      "published"      => at[5],
                      "display_name"   => at[6],
                      "unit_id"        => at[7],
                      "stackable"      => at[8],
                      "high_is_good"   => at[9],
                      "category_id"    => at[10],
                     }

        for_import.push(at_hash)
      end
        db_connection = "#{Rails.env}" # std dev or prod postgres db connection
        ActiveRecord::Base.establish_connection(db_connection.to_sym)
        DgmAttributeType.import for_import, on_duplicate_key_ignore: true
        ActiveRecord::Base.connection.close
    end
  end
end
