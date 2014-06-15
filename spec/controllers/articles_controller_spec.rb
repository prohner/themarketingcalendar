require 'spec_helper'

describe ArticlesController do

  describe "GET 'implementation_of_a_marketing_plan'" do
    it "returns http success" do
      get 'implementation_of_a_marketing_plan'
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'example_marketing_strategy'" do
    it "returns http success" do
      get 'example_marketing_strategy'
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'best_marketing_strategy'" do
    it "returns http success" do
      get 'best_marketing_strategy'
      expect(response.status).to eq(200)
    end
  end

end
