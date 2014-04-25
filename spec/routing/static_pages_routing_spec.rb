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

    it "routes to #whats_in_it_for_me" do
      expect(:get => "/whats_in_it_for_me").to route_to("static_pages#whats_in_it_for_me")
    end

    it "routes to #pricing" do
      expect(:get => "/pricing").to route_to("static_pages#pricing")
    end

  end
end
