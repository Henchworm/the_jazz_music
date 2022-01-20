
class Gig < ActiveRecord::Base

  def self.order_soonest
    order(:date)
  end
end