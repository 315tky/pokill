class Alliance < ApplicationRecord

  require 'swagger_client'

  def self.alliance_import(alliances_ids)

    for_import = []
    alliances_ids.each do |id|

      alliance_detail = self.esi_lookup(id)

      import_hash = { "alliance_id"            => id ||= '',
                     "name"                    => alliance_detail.name ||= '',
                     "creator_corporation_id"  => alliance_detail.creator_corporation_id ||= '',
                     "creator_id"              => alliance_detail.creator_id ||= '',
                     "date_founded"            => alliance_detail.date_founded ||= '',
                     "executor_corporation_id" => alliance_detail.executor_corporation_id ||= '',
                     "ticker"                  => alliance_detail.ticker ||= '' }
      for_import.push(import_hash)
    end
    Alliance.import for_import,
      on_duplicate_key_update: { conflict_target: [:alliance_id, :name],
                                columns: [:executor_corporation_id]
                                }
  end

  def self.esi_lookup(alliance_id)

    api_instance = SwaggerClient::AllianceApi.new

    opts = {
      datasource: 'tranquility', # String | The server name you would like data from
      if_none_match: 'if_none_match_example', # String | ETag from a previous request. A 304 will be returned if this matches the current ETag
    }

    begin
      #Get alliance information
      alliance_id = api_instance.get_alliances_alliance_id(alliance_id, opts)
    rescue SwaggerClient::ApiError => e
      puts "Exception when calling AllianceApi->get_alliances_alliance_id: #{e}"
    end
  end

end
