require 'spec_helper'

describe CalendarController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'events'" do
    it "returns http success" do
      get 'events'
      response.should be_success
    end
  end

  describe "GET 'repeating_events'" do
    it "returns http success" do
      get 'repeating_events'
      response.should be_success
    end
  end

end
