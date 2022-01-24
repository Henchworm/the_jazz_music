
class Gig < ActiveRecord::Base

  def self.order_soonest
     where("date >= ?", Time.now)
    .order(:date)
  end
end