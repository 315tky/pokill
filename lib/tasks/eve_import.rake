
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

  desc "get_alliances_from_corporations"
  task :alliances => :environment do
    alliances_ids = Corporation.all.pluck(:alliance_id).compact.uniq
    Alliance.alliance_import(alliances_ids)
  end

  desc "get_flags_from_local_mysql_import_to_postgres"
  task :flags => :environment do
    Flag.eve_import
  end

  desc "get_dgm_attribute_types_from_local_mysql_import_to_postgres"
  task :dgm_attribute_types => :environment do
    DgmAttributeType.eve_import
  end

# This one is the map between dgm_attributes_types and items :
  desc "get_dgm_type_attribute_from_local_mysql_import_to_postgres"
  task :dgm_type_attributes => :environment do
    DgmTypeAttribute.eve_import
  end

  desc "get_items_from_local_mysql_import_to_postgres"
  task :items => :environment do
    Item.eve_import
  end

  desc "get_regions_from_local_mysql_import_to_postgres"
  task :regions => :environment do
    Region.eve_import
  end

  desc "get_solarsystems_from_local_mysql_import_to_postgres"
  task :solarsystems => :environment do
    Solarsystem.eve_import
  end

  desc "get_constellations_from_local_mysql_import_to_postgres"
  task :constellations => :environment do
    Constellation.eve_import
  end

  desc "run_all_eve_esi_import_tasks" 
  task :all_eve_esi => :environment do
    ActiveRecord::Base.transaction do 
      tsks = %w[killmails characters corporations alliances]
      tsks.each do |tsk| 
	Rake::Task["eve_import:#{tsk}"].invoke
      end
    end
  end

  desc "run_all_eve_mysql_import_tasks"
  task :all_eve_mysql => :environment do
    ActiveRecord::Base.transaction do
      tsks = %w[constellations dgm_attribute_types dgm_type_attributes flags items regions solarsystems ]
      tsks.each do |tsk|
        Rake::Task["eve_import:#{tsk}"].invoke
      end
    end
  end

end
