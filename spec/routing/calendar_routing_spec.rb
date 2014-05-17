require "spec_helper"

describe CalendarShareController do
  describe "routing" do

    it "routes to #download_all_events_for_user" do
      expect(:get => "/download_data").to route_to("calendar#download_all_events_for_user")
    end


  end
end
