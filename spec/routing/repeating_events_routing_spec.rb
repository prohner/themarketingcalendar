require "spec_helper"

describe RepeatingEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/repeating_events").should route_to("repeating_events#index")
    end

    it "routes to #new" do
      get("/repeating_events/new").should route_to("repeating_events#new")
    end

    it "routes to #show" do
      get("/repeating_events/1").should route_to("repeating_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/repeating_events/1/edit").should route_to("repeating_events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/repeating_events").should route_to("repeating_events#create")
    end

    it "routes to #update" do
      put("/repeating_events/1").should route_to("repeating_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/repeating_events/1").should route_to("repeating_events#destroy", :id => "1")
    end

  end
end
