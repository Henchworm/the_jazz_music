require 'spec_helper'
RSpec.describe Gig do
  it "exists" do
    gig_1 = Gig.create!(
      date: "04/20/2023",
      band_name:
      "Trains and Dreams",
      music_link: "fakemusic.com")
    expect(gig_1).to be_a(Gig)
  end
end