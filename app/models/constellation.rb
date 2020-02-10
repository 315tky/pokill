class Constellation < ApplicationRecord

  has_many :solarsystems, :primary_key => "constellation_id", :foreign_key => "constellation_id"
  belongs_to :region, :primary_key => "region_id", :foreign_key => "region_id", :optional => true

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}"
      connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
      constellations = connect.connection.execute("select constellationID,
                                            constellationName,
                                            regionID,
                                            radius,
                                            x,
                                            y,
                                            z from mapConstellations").to_a
      ActiveRecord::Base.connection.close

      constellations.each do |constellation|
        for_import = { "constellation_id"   => constellation[0],
                       "constellation_name" => constellation[1],
                       "region_id"          => constellation[2],
                       "radius"             => constellation[3],
                       "x_coord"            => constellation[4],
                       "y_coord"            => constellation[5],
                       "z_coord"            => constellation[6] }
        db_connection = "#{Rails.env}"
        connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Constellation.find_or_create_by(for_import)
        ActiveRecord::Base.connection.close
      end
    end
  end
end
