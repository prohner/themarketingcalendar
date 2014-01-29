require "spec_helper"

describe CalendarShareController do
  describe "routing" do

    it "routes to #choose_calendar" do
      expect(:get => "/choose-calendar-to-share").to route_to("calendar_share#choose_calendar")
    end


  end
end
