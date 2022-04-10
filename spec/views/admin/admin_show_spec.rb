require 'spec_helper'
RSpec.describe 'the admin gig show page' do
  let!(:admin_1) { Admin.create!(username: 'billy', password: 'rocks') }
  let!(:gig_1) do
    Gig.create!(date: Time.new(2022, 10, 10), band_name: 'Trains and Dreams', venue: "Lion's Lair", deets: '21+',
                music_link: 'fakemusic.com')
  end

  it 'displays the info for a specific gig' do
    visit "/admin/gigs/#{gig_1.id}"
    expect(page).to have_content('10/10/2022')
    expect(page).to have_content(gig_1.band_name)
    expect(page).to have_content(gig_1.music_link)
  end

  it 'has button that deletes a gig' do
    visit "/admin/gigs/#{gig_1.id}"
    click_button('submit')
    expect(current_path).to eq('/admin/gigs')
    expect(page).to_not have_content(gig_1.band_name)
    expect(page).to_not have_content(gig_1.music_link)
  end

  it 'has a link to update a gig' do
    visit "/admin/gigs/#{gig_1.id}"
    click_link 'Edit this gig'
    expect(current_path).to eq("/admin/gigs/#{gig_1.id}/edit")
  end
end
