require "spec_helper"

describe StaticPagesController do
  describe "routing" do

    it "routes to #help" do
      expect(:get => "/help").to route_to("static_pages#help")
    end

    it "routes to #about" do
      expect(:get => "/about").to route_to("static_pages#about")
    end

    it "routes to #contact" do
      expect(:get => "/contact").to route_to("static_pages#contact")
    end

  end
end
