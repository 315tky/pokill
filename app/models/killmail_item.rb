class KillmailItem < ApplicationRecord
  belongs_to :killmail, :primary_key => "killmail_id", :foreign_key =>  "killmail_id", optional: true
end
