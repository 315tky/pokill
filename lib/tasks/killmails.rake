require 'pp'
require 'esi-get-recent-corp-kills.rb'

namespace :killmails do

corporation_id = 98473505 # paranoia overload eve corp id

  desc "get_killmails"
  task :get_killmails => :environment do
    session = ImportKillmail.new
    all_meta_killmails = session.get_corp_killmails_meta(corporation_id)
    for_import = session.check_db(all_meta_killmails)
    all_killmails = session.get_killmail_details(for_import)
    session.import_killmail_details(all_killmails)
   # all_killmails.each do |killmail|
   #  pp  killmail.attackers
   # end 
   # for all_killmails each get details, attackers, vitims and :  
   # populate killmail table
   # populate killmail_attackers table
   # populate killmail_victims table
    #
  end
end
