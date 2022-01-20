require 'spec_helper'
RSpec.describe Gig do
  describe "class methods" do
    let!(:gig_1) {Gig.create!(date: Time.new(2022, 10, 10), band_name: "Trains and Dreams", music_link: "fakemusic.com")}
    let!(:gig_2) {Gig.create!(date: Time.new(2022, 10, 30), band_name: "Brains and Creams", music_link: "falsemusic.com")}

    it "exists" do
      expect(gig_1).to be_a(Gig)
    end

    it "orders from soonest to latest" do
      expect(Gig.order_soonest.first).to eq(gig_1)
    end
  end
end