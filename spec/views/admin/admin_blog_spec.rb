require 'spec_helper'
RSpec.describe "the admin blarg index" do

  let!(:blarg_1) {Blarg.create!(text: "This is a blarg post.", title: "hi", subject: "music")}
  let!(:blarg_2) {Blarg.create!(text: "The quick brown Norman jumped over the lazy frog.", created_at: Time.new(2002, 10, 31),
                                title: "howdy", subject: "mountains")}

  it "shows all blargs ordered by most recent" do
    visit "/admin/blargs"
    expect(blarg_1.title).to appear_before(blarg_2.title)
    expect(blarg_1.subject).to appear_before(blarg_2.subject)
    expect(blarg_1.text).to appear_before(blarg_2.text)
  end
end