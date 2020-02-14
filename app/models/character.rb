class Character < ApplicationRecord
  require 'swagger_client'
# 95090365 <- example character_id

   def self.character_import(characters_ids)

     for_import = []
     characters_ids.each do |id|
       character_detail = self.esi_lookup(id)

       import_hash = { "character_id"    => id ||= '',
                      "name"            => character_detail.name ||= '',
                      "alliance_id"     => character_detail.alliance_id ||= '',
                      "ancestry_id"     => character_detail.ancestry_id ||= '',
                      "birthday"        => character_detail.birthday ||= '',
                      "bloodline_id"    => character_detail.bloodline_id ||= '',
                      "corporation_id"  => character_detail.corporation_id ||= '',
                      "description"     => character_detail.description ||= '',
                      "gender"          => character_detail.gender ||= '',
                      "race_id"         => character_detail.race_id ||= '',
                      "security_status" => character_detail.security_status ||= '',
                      "title"           => character_detail.title }
        for_import.push(import_hash)
     end
     Character.import for_import,
       on_duplicate_key_update: {conflict_target: [:character_id, :name],
                                 columns: [:alliance_id,
                                           :ancestry_id,
                                           :birthday,
                                           :bloodline_id,
                                           :corporation_id,
                                           :description,
                                           :gender,
                                           :race_id,
                                           :security_status,
                                           :title ]}
   end

   def self.esi_lookup(character_id)  # we have to import from EVE ESI not from SDE

     api_instance = SwaggerClient::CharacterApi.new
     opts = {
      datasource: 'tranquility', # String | The server name you would like data from
      if_none_match: 'if_none_match_example', # String | ETag from a previous request. A 304 will be returned if this matches the current ETag
     }
    begin
      #Get character's public information
      character_info = api_instance.get_characters_character_id(character_id, opts)
    rescue SwaggerClient::ApiError => e
      puts "Exception when calling CharacterApi->get_characters_character_id: #{e}"
    end
  end

end
