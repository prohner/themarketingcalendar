require 'spec_helper'

describe GetGoingController do
  let(:user) { FactoryGirl.create(:user_dave) }
  
  before(:each) do
    sign_in user
  end


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

  describe "GET 'twitter_add'" do
    it "should asssign the necessary variables" do
      get 'twitter_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).not_to be_nil
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:next_action)).to be_a(Symbol)
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end
end
