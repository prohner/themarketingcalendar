require 'spec_helper'

describe CalendarShareController do
  let(:user) { FactoryGirl.create(:user_dave) }
  let(:category_groups) { user.all_category_groups }
  
  before(:each) do
    sign_in user#, :no_capybara => true
  end

  describe "GET 'choose_calendar'" do
    it "returns http success" do
      get 'choose_calendar'
      expect(response).to be_success
    end
    
    it "should assign calendars" do
      get 'choose_calendar'
      expect(assigns(:category_groups)).to match_array(category_groups)
      
    end
  end

  describe "GET 'choose_user'" do
    it "returns http success" do
      post 'choose_user', category_groups: [1, 2]
      expect(response).to be_success
    end
  end

  describe "GET 'share_calendars'" do
    it "returns http success" do
      post 'share_calendars', { :i => "3 5", :email => "a@b.com, c@d.com,e@f.com" }
      expect(response).to be_success
    end
  end

end
