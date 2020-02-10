class Killmail < ApplicationRecord
  has_many :killmail_attackers, :primary_key => "killmail_id", :foreign_key => "killmail_id", dependent: :destroy
  has_many :killmail_items, :primary_key => "killmail_id", :foreign_key =>  "killmail_id", dependent: :destroy
  belongs_to :solarsystem, :primary_key => "solar_system_id", :foreign_key => "solar_system_id"
end
