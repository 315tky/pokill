class KillmailItem < ApplicationRecord
  belongs_to :killmail, :foreign_key =>  "killmail_id", optional: true
end
