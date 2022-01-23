require 'spec_helper'
RSpec.describe "the admin gig show page" do

  let!(:gig_1) {Gig.create!(date: Time.new(2022, 10, 10), band_name: "Trains and Dreams",venue: "Lion's Lair", deets: "21+", music_link: "fakemusic.com")}


  it "displays the info for a specific gig" do
    visit "/admin/gigs/#{gig_1.id}"
    expect(page).to have_content("10/10/2022")
    expect(page).to have_content(gig_1.band_name)
    expect(page).to have_content(gig_1.music_link)
  end
end
