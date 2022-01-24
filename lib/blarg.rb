class Blarg < ActiveRecord::Base

  def self.order_soonest
    self.order("created_at DESC")
  end

end