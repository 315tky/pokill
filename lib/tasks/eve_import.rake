
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
    Character.character_import(victims_ids)

    attackers = KillmailAttacker.all
    attackers_ids = attackers.map { |attacker| attacker.attacker_id }.compact.uniq
    Character.character_import(attackers_ids)
  end

  desc "get_corporations_from_characters"
  task :corporations => :environment do
    characters = Character.all
    corporations_ids = characters.map { |character| character.corporation_id }.compact.uniq
    Corporation.corporation_import(corporations_ids)
  end

  desc "get_flags_from_local_mysql_import_to_postgres"
  task :flags => :environment do
    Flag.eve_import
  end

  desc "get_items_from_local_mysql_import_to_postgres"
  task :items => :environment do
    Item.eve_import
  end
end
