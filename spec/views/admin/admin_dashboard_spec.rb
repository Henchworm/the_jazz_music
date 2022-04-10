require 'spec_helper'
RSpec.describe 'admin dashboard' do
  let!(:admin_1) { Admin.create!(username: 'billy', password: 'rocks') }

  it 'has links to all admin functionalities' do
    visit '/admin/dashboard'
    expect(page).to have_link('Blarg Stuff')
    expect(page).to have_link('Gig Stuff')
  end
end
