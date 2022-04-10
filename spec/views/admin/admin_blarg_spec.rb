require 'spec_helper'
RSpec.describe 'the admin blarg index' do
  let!(:blarg_1) { Blarg.create!(text: 'This is a blarg post.', title: 'hi', subject: 'music') }
  let!(:blarg_2) do
    Blarg.create!(text: 'The quick brown Norman jumped over the lazy frog.', created_at: Time.new(2002, 10, 31),
                  title: 'howdy', subject: 'mountains')
  end
  let!(:admin_1) { Admin.create!(username: 'johnny', password: 'rocks') }

  it 'shows all blargs ordered by most recent' do
    visit '/admin/blargs'
    fill_in :username, with: 'johnny'
    fill_in :password, with: 'rocks'
    click_button 'Submit'
    visit '/admin/blargs'
    expect(blarg_1.title).to appear_before(blarg_2.title)
    expect(blarg_1.subject).to appear_before(blarg_2.subject)
    expect(blarg_1.text).to appear_before(blarg_2.text)
  end

  it 'has a link that create a new blarg' do
    visit '/admin/blargs'
    click_link('Create a new Blarg')
    expect(current_path).to eq('/admin/blargs/new')
    fill_in :title, with: 'The Jazz Music'
    fill_in :text, with: 'This is a blog post'
    fill_in :subject, with: 'RSpec'
    click_button 'submit'
    expect(current_path).to eq('/admin/blargs')
    expect(page).to have_content(Blarg.all.last.title)
    expect(page).to have_content(Blarg.all.last.text)
    expect(page).to have_content(Blarg.all.last.subject)
  end
end
