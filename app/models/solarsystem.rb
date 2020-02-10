class Solarsystem < ApplicationRecord

  has_many :killmails, :primary_key => "solar_system_id", :foreign_key => "solar_system_id"

  def self.eve_import
    ActiveRecord::Base.transaction do
      db_connection = "eve_#{Rails.env}"
      connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
      systems = connect.connection.execute("select solarSystemID,
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
    end

    ActiveRecord::Base.transaction do
      systems.each do |system|
        for_import = { "system_id"         => system[0],
                       "system_name" => system[1],
                       "region_id"         => system[2],
                       "constellation_id"  => system[3],
                       "sun_type_id"       => system[4],
                       "security"          => system[5],
                       "security_class"    => system[6],
                       "radius"            => system[7],
                       "x_coord"                => system[8],
                       "y_coord"                => systems[9],
                       "z_coord"                => system[10] }
        db_connection = "#{Rails.env}"
        connect = ActiveRecord::Base.establish_connection(db_connection.to_sym)
        Solarsystem.find_or_create_by(for_import)
        ActiveRecord::Base.connection.close
      end
    end
  end

end
