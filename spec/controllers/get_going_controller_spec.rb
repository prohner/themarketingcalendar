require 'spec_helper'

describe GetGoingController do

  describe "GET 'start'" do
    it "returns http success" do
      get 'start'
      expect(response).to be_success
    end
  end

  describe "GET 'home_biz'" do
    it "returns http success" do
      get 'home_biz'
      expect(response).to be_success
    end
  end

  describe "GET 'small_biz'" do
    it "returns http success" do
      get 'small_biz'
      expect(response).to be_success
    end
  end

  describe "GET 'medium_biz'" do
    it "returns http success" do
      get 'medium_biz'
      expect(response).to be_success
    end
  end

  describe "GET 'large_biz'" do
    it "returns http success" do
      get 'large_biz'
      expect(response).to be_success
    end
  end

end
