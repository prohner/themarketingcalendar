require 'spec_helper'

feature "Help Page" do
  scenario "User visits help page" do
    visit "/static_pages/help.html"
    expect(page).to have_title "#{application_name} | Help"
  end
end
