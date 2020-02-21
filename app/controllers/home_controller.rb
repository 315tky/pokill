class HomeController < ApplicationController
  def index
    @killmails = Killmail.includes(:killmail_items, :killmail_attackers).order(killmail_time: :desc)

    @killmails_last_hour = Killmail.where(killmail_time: 60.minutes.ago.utc..).count
    @killmails_last_day = Killmail.where(killmail_time: 1.day.ago.utc..).count
    @killmails_last_week = Killmail.where(killmail_time: 1.week.ago..).count
    @killmails_last_month = Killmail.where(killmail_time: 1.month.ago..).count
  end
end
