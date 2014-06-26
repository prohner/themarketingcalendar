require 'spec_helper'

feature "Help Page" do
  scenario "User visits help page" do
    visit "/static_pages/help.html"
    expect(page).to have_title "Help | #{application_name}"
  end
end
