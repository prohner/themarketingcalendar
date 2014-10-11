require "spec_helper"

describe ColorSchemesController do
  describe "routing" do

    it "routes to #index" do
      get("/color_schemes").should route_to("color_schemes#index")
    end

    it "routes to #new" do
      get("/color_schemes/new").should route_to("color_schemes#new")
    end

    it "routes to #show" do
      get("/color_schemes/1").should route_to("color_schemes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/color_schemes/1/edit").should route_to("color_schemes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/color_schemes").should route_to("color_schemes#create")
    end

    it "routes to #update" do
      put("/color_schemes/1").should route_to("color_schemes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/color_schemes/1").should route_to("color_schemes#destroy", :id => "1")
    end

  end
end
