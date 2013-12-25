require 'spec_helper'

describe "Signup Page" do
  subject { page }
  
  describe "User visits profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.first_name) }
    it { should have_title(user.full_name) }

  end
  
  describe "User visits contact page" do
    before { visit signup_path }
    
    it { should have_title("The Marketing Calendar | Signup") }
  end
end
