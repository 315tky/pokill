require 'pp'

namespace :corporation do

#corporation_id = 98473505 # paranoia overload eve corp id

  desc "get_corporations_from_characters"
  task :get_corporations => :environment do
    characters = Character.all
    corporations_ids = characters.map { |character| character.corporation_id }.compact.uniq
    corporations_ids.each do |id|
      Corporation.corporation_import([id])
    end
  end
end
