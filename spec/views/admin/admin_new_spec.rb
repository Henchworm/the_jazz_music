require 'spec_helper'
RSpec.describe "the admin new gig page" do
  it "fills in form to create new gig" do
    visit '/admin/gigs/new'

    fill_in :date, with: "05/20/2024"
    fill_in :band_name, with: "Madagascar Sentries"
    fill_in :music_link, with: "www.fakelink.com"
    click_button :submit
    expect(current_path).to eq("/admin/gigs")
    expect(page).to have_content("05/20/2024")
    expect(page).to have_content("Madagascar Sentries")
    expect(page).to have_content("www.fakelink.com")
  end
end