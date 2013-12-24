require 'spec_helper'

# describe "static_pages/home.html.erb" do
#   it "should have the content 'welcome'" do
#     visit 
#   end
# end

feature "Home Page" do
  scenario "User visits home page" do
    visit "/static_pages/home.html"
    expect(page).to have_title "#{application_name} | Home"
  end
end
