require 'spec_helper'
RSpec.describe 'the gigs index page' do
  let!(:gig_1) {Gig.create!(date: "04/20/2023", band_name: "Trains and Dreams", music_link: "fakemusic.com")}
  let!(:gig_2) {Gig.create!(date: "04/20/2023", band_name: "Trains and Dreams", music_link: "fakemusic.com")}

  it "shows the current upcoming gigs" do
    visit "/gigs"
    expect(page).to have_content(gig_1.date)
    expect(page).to have_content(gig_2.date)
    expect(page).to have_content(gig_1.band_name)
    expect(page).to have_content(gig_2.band_name)
    expect(page).to have_content(gig_1.music_link)
    expect(page).to have_content(gig_2.music_link)
  end
end