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
  
  describe "signing up" do
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "First name",   with: "BillFirst"
        fill_in "Last name",    with: "BillLast"
        fill_in "Email",        with: "bill@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: user.email) }
        
        it { should have_link('Sign out') }
        it { should have_title("The Marketing Calendar | BillFirst BillLast") }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
    
  end

  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
    end
    
    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end
    
    describe "with valid information" do
    end
  end

end
