class Region < ApplicationRecord

  has_many :solarsystems, :primary_key => "region_id", :foreign_key => "region_id"
  has_many :constellations, :primary_key => "region_id", :foreign_key => 'region_id'

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}"
      ActiveRecord::Base.establish_connection(db_connection.to_sym)
      regions = ActiveRecord::Base.connection.execute("select regionID,
                                                        regionName,
                                                        radius,
                                                        x,
                                                        y,
                                                        z from mapRegions").to_a
      ActiveRecord::Base.connection.close
      for_import = []
      regions.each do |region|
        regions_hash = { "region_id"   => region[0],
                         "region_name" => region[1],
                         "radius"      => region[2],
                         "x_coord"     => region[3],
                         "y_coord"     => region[4],
                         "z_coord"     => region[5] }
        for_import.push(regions_hash)
     end
        db_connection = "#{Rails.env}"
        ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Region.import for_import, on_duplicate_key_ignore: true # regions should never change so not gonna bother with the on_duplicate_key_update
        ActiveRecord::Base.connection.close
    end
  end
end
