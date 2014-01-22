require 'spec_helper'

describe CalendarController do

  describe "GET 'index'" do
    it "redirect to signin path" do
      get 'index'
      response.should redirect_to(signin_url)
    end
  end

  describe "GET 'events'" do
    it "returns http success" do
      get 'events'
      response.should redirect_to(signin_url)
    end
  end

  describe "when signed in" do
    before(:each) do
      @bill = FactoryGirl.create(:user_bill)
      @dave = FactoryGirl.create(:user_dave)
      
    end
    
    it "should have the right number of events" do
      
      puts_user @bill
      @bill.should be_valid
    end
  end
end
