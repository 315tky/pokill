class Solarsystem < ApplicationRecord

  has_many :killmails, :primary_key => "solar_system_id", :foreign_key => "solar_system_id"
  belongs_to :region, :primary_key  => "region_id", :foreign_key => "region_id", optional: true
  belongs_to :constellation, :primary_key => "constellation_id", :foreign_key => "constellation_id", optional: true

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}"
      ActiveRecord::Base.establish_connection(db_connection.to_sym)
      systems = ActiveRecord::Base.connection.execute("select solarSystemID,
                                                        solarSystemName,
                                                        regionID,
                                                        constellationID,
                                                        sunTypeID,
                                                        security,
                                                        securityClass,
                                                        radius,
                                                        x,
                                                        y,
                                                        z from mapSolarSystems").to_a
      ActiveRecord::Base.connection.close
      for_import = []
      systems.each do |system|
        systems_hash = { "solar_system_id"   => system[0],
                         "system_name"       => system[1],
                         "region_id"         => system[2],
                         "constellation_id"  => system[3],
                         "sun_type_id"       => system[4],
                         "security"          => system[5],
                         "security_class"    => system[6],
                         "radius"            => system[7],
                         "x_coord"           => system[8],
                         "y_coord"           => system[9],
                         "z_coord"           => system[10] }
        for_import.push(systems_hash)
      end
        db_connection = "#{Rails.env}"
        ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Solarsystem.import for_import, on_duplicate_key_ignore: true
        ActiveRecord::Base.connection.close
    end
  end
end
