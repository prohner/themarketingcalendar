require "spec_helper"

describe CategoryGroupsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/category_groups").to route_to("category_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/category_groups/new").to route_to("category_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/category_groups/1").to route_to("category_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/category_groups/1/edit").to route_to("category_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/category_groups").to route_to("category_groups#create")
    end

    it "routes to #update" do
      expect(:put => "/category_groups/1").to route_to("category_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/category_groups/1").to route_to("category_groups#destroy", :id => "1")
    end

  end
end
