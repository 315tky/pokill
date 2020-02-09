#!/bin/env ruby
require 'swagger_client'
require 'net/http'
require 'uri'
require 'json'
require 'pp'

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
pp "get auth ran"
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
pp "got all meta killmails"
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
    for_import = for_import.uniq
    return for_import
  end

  def get_killmail_details(for_import)
pp "starting to look up single mails from meta"
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
    pp single_killmails
    return single_killmails
  end

  def import_killmail_details(single_killmails)

    single_killmails.each do |killmail|
      killmail_details = {  "killmail_id"     => killmail.killmail_id ||= '',
                            "killmail_time"   => killmail.killmail_time ||= '',
                            "solar_system_id" => killmail.solar_system_id ||= '',
                            "victim_id"       => killmail.victim.character_id ||= '',
                            "victim_corporation_id" => killmail.victim.corporation_id ||= '',
                            "victim_damage_taken"   => killmail.victim.damage_taken ||= '',
			                      "victim_position"       => killmail.victim.position.to_json ||= '',
                            "victim_ship_id"        => killmail.victim.ship_type_id ||= '' }

      killmail_attackers = killmail.attackers.map { |attacker| { "killmail_id" => killmail.killmail_id ||= '',
                                                                 "attacker_id" => attacker.character_id ||= '',
                                                                 "corporation_id" => attacker.corporation_id ||= '',
                                                                 "alliance_id" => attacker.alliance_id ||= '',
                                                                 "damage_done" => attacker.damage_done ||= '',
                                                                 "final_blow"  => attacker.final_blow ||= false,
                                                                 "security_status" => attacker.security_status ||= '',
                                                                 "ship_type_id"  => attacker.ship_type_id ||= '',
                                                                 "weapon_type_id" => attacker.weapon_type_id ||= ''
                                                                 } }
      killmail_attackers.each do |attacker|
        KillmailAttacker.create(attacker)
      end
      Killmail.create(killmail_details)
    end
  end

end
  # Add some code to this so that it checks each killmail_hash against the DB, or, do a check with ID, if can gurantee they are sequential. Then only looks up those in CCP ESI that are not found in local DB, less lookups to CCP ESI.
  # Get last killmail_id from DB, then look up any that are higher than that number in CCP ESI.
  # turn this into a class with 3 methods, then make a rake task that calls it, and gets the killmails.   # The rake task can update the database, need to check DB for last killmail timestamp and do a date relevant update for just those killmails not yet imported.
