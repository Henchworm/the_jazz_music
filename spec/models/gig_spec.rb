require 'spec_helper'
RSpec.describe Gig do
  describe "class methods" do
    let!(:gig_1) {Gig.create!(date: Time.new(2022, 10, 10), band_name: "Trains and Dreams",venue: "Lion's Lair", deets: "21+", music_link: "fakemusic.com")}
    let!(:gig_2) {Gig.create!(date: Time.new(2022, 10, 30), band_name: "Brains and Creams",venue: "Lion's Lair", deets: "21+", music_link: "falsemusic.com")}
    let!(:gig_3) {Gig.create!(date: Time.new(2018, 10, 30), band_name: "Dead Ancient Band",venue: "Lion's Lair", deets: "21+", music_link: "notrealmusic.com")}


    it "exists" do
      expect(gig_1).to be_a(Gig)
    end

    it "orders from soonest to latest and doesnt display old gigs" do
      expect(Gig.order_soonest).to eq([gig_1, gig_2])
    end
  end
end