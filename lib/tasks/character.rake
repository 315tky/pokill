require 'pp'

namespace :character do

corporation_id = 98473505 # paranoia overload eve corp id

  desc "get_characters_from_killmails"
  task :get_characters => :environment do
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
end
