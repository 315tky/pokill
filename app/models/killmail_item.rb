class KillmailItem < ApplicationRecord
  belongs_to :killmail, :primary_key => "killmail_id", :foreign_key =>  "killmail_id", optional: true
  belongs_to :flag, :primary_key => "flag_id", :foreign_key => "flag_id", :optional => true
  belongs_to :item, :primary_key => "item_type_id", :foreign_key => "flag_id", :optional => true
end
