require "spec_helper"

describe CategoryGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/category_groups").should route_to("category_groups#index")
    end

    it "routes to #new" do
      get("/category_groups/new").should route_to("category_groups#new")
    end

    it "routes to #show" do
      get("/category_groups/1").should route_to("category_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/category_groups/1/edit").should route_to("category_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/category_groups").should route_to("category_groups#create")
    end

    it "routes to #update" do
      put("/category_groups/1").should route_to("category_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/category_groups/1").should route_to("category_groups#destroy", :id => "1")
    end

  end
end
