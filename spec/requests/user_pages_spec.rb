require 'spec_helper'

feature "Signup Page" do
  
  scenario "User visits contact page" do
    visit signup_path
    
    expect(page).to have_title "The Marketing Calendar | Signup"
  end
end
