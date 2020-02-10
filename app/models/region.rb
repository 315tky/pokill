class Region < ApplicationRecord

  has_many :solarsystems, :primary_key => "region_id", :foreign_key => "region_id"
  has_many :constellations, :primary_key => "region_id", :foreign_key => 'region_id'

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}"
      connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
      regions = connect.connection.execute("select regionID,
                                            regionName,
                                            radius,
                                            x,
                                            y,
                                            z from mapRegions").to_a
      ActiveRecord::Base.connection.close

      regions.each do |region|
        for_import = { "region_id"   => region[0],
                       "region_name" => region[1],
                       "radius"      => region[2],
                       "x_coord"     => region[3],
                       "y_coord"     => region[4],
                       "z_coord"     => region[5] }
        db_connection = "#{Rails.env}"
        connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Region.find_or_create_by(for_import)
        ActiveRecord::Base.connection.close
      end
    end
  end

end
