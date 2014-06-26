require 'spec_helper'

feature "About Page" do
  scenario "User visits about page" do
    visit "/static_pages/about.html"
    expect(page).to have_title "About | #{application_name}"
  end
end
