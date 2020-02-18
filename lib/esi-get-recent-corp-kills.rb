#!/bin/env ruby
require 'swagger_client'
require 'net/http'
require 'uri'
require 'json'

 class ImportKillmail

  def initialize

    @logger = Rails.logger
    uri = URI.parse("https://login.eveonline.com/oauth/token")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    # need to pull these codes out into ENV variables before commit to git
    request["Authorization"] = "Basic #{ENV['BASE64_ENCODE']}"
    request.body = JSON.dump({
      "grant_type" => "refresh_token",
      "refresh_token" => "#{ENV['REFRESH_TOKEN']}"
    })
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    session_access_token = JSON.parse(response.body)["access_token"]

    SwaggerClient.configure do |config|
      # Configure OAuth2 access token for authorization: evesso
      config.access_token = session_access_token
    end
    @api_instance = SwaggerClient::KillmailsApi.new
  end

  def get_corp_killmails_meta(corporation_id)

    all_killmails_opts = {
      datasource: 'tranquility', # String | The server name you would like data from
      if_none_match: 'if_none_match_example', # String | ETag from a previous request. A 304 will be returned if this matches the current ETag
      page: 1, # Integer | Which page of results to return
      token: '' # String | Access token to use if unable to set a header
    }
    begin
      all_meta_killmails = @api_instance.get_corporations_corporation_id_killmails_recent(corporation_id, all_killmails_opts)
    rescue SwaggerClient::ApiError => e
      @logger.error "Exception when calling KillmailsApi->get_corporations_corporation_id_killmails_recent: #{e}"
    end
    return all_meta_killmails
  end

  def check_db(all_meta_killmails) # check pokill db for killmail already imported, return any that are not

    for_import = []
    all_meta_killmails.each do |meta_killmail|
       killmail_id = meta_killmail.killmail_id
       unless Killmail.find_by(killmail_id: killmail_id)
         meta_hash_id = {}
         meta_hash_id["killmail_hash"] = meta_killmail.killmail_hash
         meta_hash_id["killmail_id"]   = meta_killmail.killmail_id
         for_import.push(meta_hash_id)
       end
    end
    for_import = for_import.uniq # de-duplicate because CCP has dup killmails with same hash and id
    return for_import
  end

  def get_killmail_details(for_import)

    single_killmail_opts = {
      datasource: 'tranquility', # String | The server name you would like data from
      if_none_match: 'if_none_match_example', # String | ETag from a previous request. A 304 will be returned if this matches the current ETag
    }
    single_killmails = []
    for_import.each do |e|
      killmail_hash = e['killmail_hash']
      killmail_id   = e['killmail_id']
      begin
        single_killmail = @api_instance.get_killmails_killmail_id_killmail_hash(killmail_hash, killmail_id, single_killmail_opts)
        single_killmails.push(single_killmail)
      rescue SwaggerClient::ApiError => e
	 @logger.error "Exception when calling KillmailsApi->get_killmails_killmail_id_killmail_hash: #{e}"
      end
    end
    return single_killmails
  end

  def import_killmail_details(single_killmails)

    ActiveRecord::Base.transaction do
      for_import = []
      single_killmails.each do |killmail|
         kill_hash = {  "killmail_id"           => killmail.killmail_id ||= '',
                        "killmail_time"         => killmail.killmail_time ||= '',
                        "solar_system_id"       => killmail.solar_system_id ||= '',
                        "victim_id"             => killmail.victim.character_id ||= '',
                        "victim_corporation_id" => killmail.victim.corporation_id ||= '',
                        "victim_damage_taken"   => killmail.victim.damage_taken ||= '',
                        "victim_position"       => killmail.victim.position.to_json ||= [],
                        "victim_ship_id"        => killmail.victim.ship_type_id ||= ''
                      }

        for_import.push(kill_hash)

        for_attackers_import = []
        killmail.attackers.each do |attacker|

          attackers_hash = { "killmail_id"     => killmail.killmail_id ||= '',
                             "attacker_id"     => attacker.character_id ||= '',
                             "corporation_id"  => attacker.corporation_id ||= '',
                             "alliance_id"     => attacker.alliance_id ||= '',
                             "damage_done"     => attacker.damage_done ||= '',
                             "final_blow"      => attacker.final_blow ||= false,
                             "security_status" => attacker.security_status ||= '',
                             "ship_type_id"    => attacker.ship_type_id ||= '',
                             "weapon_type_id"  => attacker.weapon_type_id ||= ''
                           }
          for_attackers_import.push(attackers_hash)
        end
        KillmailAttacker.import for_attackers_import, on_duplicate_key_ignore: true # ActiveRecord Import

        for_items_import = []
        killmail.victim.items.each do |item|
          items_hash =  {  "killmail_id"        => killmail.killmail_id ||= '',
                           "item_type_id"       => item.item_type_id ||= '',
                           "flag_id"            => item.flag ||= '',
                           "quantity_destroyed" => item.quantity_destroyed ||= '',
                           "quantity_dropped"   => item.quantity_dropped ||= '',
                           "singleton"          => item.singleton || ''
                         }
          for_items_import.push(items_hash)
        end
        KillmailItem.import for_items_import, on_duplicate_key_ignore: true # Active Record Import
      end
      Killmail.import for_import # ActiveRecord Import
    end
  end
end
