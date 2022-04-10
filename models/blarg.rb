class Blarg < ActiveRecord::Base
  def self.order_soonest
    order('created_at DESC')
  end
end
