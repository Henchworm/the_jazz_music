require 'spec_helper'
RSpec.describe 'the admin gigs index page' do
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
  let!(:admin_1) { Admin.create!(username: 'billy', password: 'rocks') }

  describe 'logged in paths' do
    it 'has a link to create a gig' do
      visit '/admin/gigs'
      click_link('Create a New Gig')
      expect(current_path).to eq('/admin/gigs/new')
    end

    it 'shows the current upcoming gigs' do
      visit '/admin/gigs'
      expect(page).to have_content('10/10/2022')
      expect(page).to have_content('10/30/2022')
      expect(page).to have_content(gig_1.band_name)
      expect(page).to have_content(gig_2.band_name)
      expect(page).to have_content(gig_1.music_link)
      expect(page).to have_content(gig_2.music_link)
    end

    it 'orders by how soon gigs are' do
      visit '/admin/gigs'
      expect(gig_1.band_name).to appear_before(gig_2.band_name)
      expect(gig_1.music_link).to appear_before(gig_2.music_link)
    end

    it 'doesnt show gig that have already happened' do
      visit '/admin/gigs'
      expect(page).to_not have_content(gig_3.date)
      expect(page).to_not have_content(gig_3.band_name)
      expect(page).to_not have_content(gig_3.music_link)
    end

    it 'has links to each gigs show page' do
      visit '/admin/gigs'
      click_link("View Gig ##{gig_1.id}")
      expect(current_path).to eq("/admin/gigs/#{gig_1.id}")
    end
  end
end
