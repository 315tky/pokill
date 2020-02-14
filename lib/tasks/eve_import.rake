
require 'esi-get-recent-corp-kills.rb'



namespace :eve_import do

  corporation_id = 98473505 # paranoia overload eve corp id

  desc "get_killmails"
  task :killmails => :environment do
    session = ImportKillmail.new
    all_meta_killmails = session.get_corp_killmails_meta(corporation_id)
    for_import = session.check_db(all_meta_killmails)
    all_killmails = session.get_killmail_details(for_import)
    session.import_killmail_details(all_killmails)
  end

  desc "get_characters_from_killmails"
  task :characters => :environment do
    killmails = Killmail.all
    victims_ids = killmails.map { |killmail| killmail.victim_id }.compact.uniq
    victims_ids.each do |id|
      Character.character_import([id])
    end
    attackers = KillmailAttacker.all
    attackers_ids = attackers.map { |attacker| attacker.attacker_id }.compact.uniq
    attackers_ids.each do |id|
      Character.character_import([id])
    end
  end

  desc "get_corporations_from_characters"
  task :corporations => :environment do
    characters = Character.all
    corporations_ids = characters.map { |character| character.corporation_id }.compact.uniq
    corporations_ids.each do |id|
      Corporation.corporation_import([id])
    end
  end
end
