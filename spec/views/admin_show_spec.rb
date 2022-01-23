require 'spec_helper'
RSpec.describe "the admin gig show page" do
  let!(:gig_1) {Gig.create!(date: Time.new(2022, 10, 10), band_name: "Trains and Dreams", music_link: "fakemusic.com")}


  it "displays the info for a specific gig" do
    visit "/admin/gigs/#{gig_1.id}"
    save_and_open_page

    expect(page).to have_content(gig_1.date)
    expect(page).to have_content(gig_1.band_name)
    expect(page).to have_content(gig_1.music_link)
    save_and_open_page
  end
end
