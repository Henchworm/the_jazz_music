require 'spec_helper'
RSpec.describe "the welcome page" do

  it "has link to gigs" do
    visit "/"
    click_link("Gigs")
    expect(current_path).to eq("/gigs")
  end

  it "has link to bandcamp" do
    visit "/"
    click_link("Blarg")
    expect(current_path).to eq("/blargs")
  end
end