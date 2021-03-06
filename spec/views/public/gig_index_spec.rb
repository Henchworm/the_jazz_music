require 'spec_helper'
RSpec.describe 'the gigs index page' do
  let!(:gig_1) do
    Gig.create!(date: Time.new(2022, 10, 10), band_name: 'Trains and Dreams', venue: "Lion's Lair", deets: '21+',
                music_link: 'fakemusic.com')
  end
  let!(:gig_2) do
    Gig.create!(date: Time.new(2022, 10, 30), band_name: 'Brains and Creams', venue: "Lion's Lair", deets: '21+',
                music_link: 'falsemusic.com')
  end
  let!(:gig_3) do
    Gig.create!(date: Time.new(2018, 10, 30), band_name: 'Dead Ancient Band', venue: "Lion's Lair", deets: '21+',
                music_link: 'notrealmusic.com')
  end

  it 'shows the current upcoming gigs' do
    visit '/gigs'
    expect(page).to have_content('10/10/2022')
    expect(page).to have_content('10/30/2022')
    expect(page).to have_content(gig_1.band_name)
    expect(page).to have_content(gig_2.band_name)
    expect(page).to have_content(gig_1.venue)
    expect(page).to have_content(gig_2.venue)
    expect(page).to have_content(gig_1.deets)
    expect(page).to have_content(gig_2.deets)
  end

  it 'orders by how soon gigs are' do
    visit '/gigs'
    expect(gig_1.band_name).to appear_before(gig_2.band_name)
  end

  it 'doesnt show gig that have already happened' do
    visit '/gigs'
    expect(page).to_not have_content(gig_3.date)
    expect(page).to_not have_content(gig_3.band_name)
  end
end
