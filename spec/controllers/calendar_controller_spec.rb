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

  describe "GET 'repeating_events'" do
    it "returns http success" do
      get 'repeating_events'
      response.should redirect_to(signin_url)
    end
  end

end
