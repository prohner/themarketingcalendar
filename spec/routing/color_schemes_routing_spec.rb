require "spec_helper"

describe ColorSchemesController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/color_schemes").to route_to("color_schemes#index")
    end

    it "routes to #new" do
      expect(:get => "/color_schemes/new").to route_to("color_schemes#new")
    end

    it "routes to #show" do
      expect(:get => "/color_schemes/1").to route_to("color_schemes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/color_schemes/1/edit").to route_to("color_schemes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/color_schemes").to route_to("color_schemes#create")
    end

    it "routes to #update" do
      expect(:put => "/color_schemes/1").to route_to("color_schemes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/color_schemes/1").to route_to("color_schemes#destroy", :id => "1")
    end

  end
end
