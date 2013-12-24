require 'spec_helper'

feature "Contact Page" do
  scenario "User visits contact page" do
    visit "/static_pages/contact.html"
    expect(page).to have_title "#{application_name} | Contact"
  end
end
