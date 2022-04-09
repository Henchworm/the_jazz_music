require 'spec_helper'
RSpec.describe 'the admin gigs index page update' do

  let!(:gig_1) {Gig.create!(date: Time.new(2022, 10, 10), band_name: "Trains and Dreams",venue: "Lion's Lair", deets: "21+", music_link: "fakemusic.com")}
  let!(:admin_1) {Admin.create!(username: 'billy', password:'rocks')}

  it "updates an existing gig and redirects to the admin index" do
    visit "/admin/gigs/#{gig_1.id}/edit"
    fill_in :date, with: "05/20/2024"
    fill_in :band_name, with: "Madagascar Sentries"
    fill_in :venue, with: "Mike's Car Hole"
    fill_in :deets, with: "Bring earmuffs"
    fill_in :music_link, with: "www.fakelink.com"
    click_button :submit
    expect(current_path).to eq("/admin/gigs")
  end
end