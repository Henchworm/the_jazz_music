require 'spec_helper'
RSpec.describe Blarg do
  describe "class methods" do
    let!(:blarg_1) {Blarg.create!(text: "This is a blarg post.", title: "hi", subject: "music")}
    let!(:blarg_2) {Blarg.create!(text: "The quick brown Norman jumped over the lazy frog.", created_at: Time.new(2002, 10, 31),
                                  title: "howdy", subject: "mountains")}


    it "exists" do
      expect(blarg_1).to be_a(Blarg)
    end

    it "orders from soonest to latest and doesnt display old gigs" do
      expect(Blarg.order_soonest).to eq([blarg_1, blarg_2])
    end
  end
end