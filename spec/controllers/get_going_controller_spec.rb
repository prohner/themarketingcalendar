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

  describe "GET 'easily'" do
    it "returns http success" do
      get 'easily'
      expect(response).to be_success
    end
  end

  describe "GET 'twitter_add'" do
    it "should asssign the necessary variables" do
      get 'twitter_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:twitter)
      expect(assigns(:next_action)).to eq(:facebook_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq ("twitter_icon.jpg")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'facebook_add'" do
    it "should asssign the necessary variables" do
      get 'facebook_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:facebook)
      expect(assigns(:next_action)).to eq(:google_plus_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("facebook_icon.png")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'google_plus_add'" do
    it "should asssign the necessary variables" do
      get 'google_plus_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:google_plus)
      expect(assigns(:next_action)).to eq(:instagram_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("google_plus_icon.jpg")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'instagram_add'" do
    it "should asssign the necessary variables" do
      get 'instagram_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:instagram)
      expect(assigns(:next_action)).to eq(:pinterest_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("instagram_icon.jpg")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'pinterest_add'" do
    it "should asssign the necessary variables" do
      get 'pinterest_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:pinterest)
      expect(assigns(:next_action)).to eq(:search_engine_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("pinterest_icon.jpg")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'search_engine_add'" do
    it "should asssign the necessary variables" do
      get 'search_engine_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:google_search)
      expect(assigns(:next_action)).to eq(:facebook_ad_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'facebook_ad_add'" do
    it "should asssign the necessary variables" do
      get 'facebook_ad_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:facebook_ads)
      expect(assigns(:next_action)).to eq(:blogging_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("facebook_icon.png")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'blogging_add'" do
    it "should asssign the necessary variables" do
      get 'blogging_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:blogging)
      expect(assigns(:next_action)).to eq(:podcasting_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'podcasting_add'" do
    it "should asssign the necessary variables" do
      get 'podcasting_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:podcasting)
      expect(assigns(:next_action)).to eq(:webinar_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'webinar_add'" do
    it "should asssign the necessary variables" do
      get 'webinar_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:webinars)
      expect(assigns(:next_action)).to eq(:email_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'email_add'" do
    it "should asssign the necessary variables" do
      get 'email_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:email)
      expect(assigns(:next_action)).to eq(:direct_mail_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'direct_mail_add'" do
    it "should asssign the necessary variables" do
      get 'direct_mail_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:direct_mail)
      expect(assigns(:next_action)).to eq(:trade_show_add)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end

  describe "GET 'trade_show_add'" do
    it "should asssign the necessary variables" do
      get 'trade_show_add'
      expect(assigns(:events)).not_to be_nil
      expect(assigns(:event_type)).to eq(:trade_shows)
      expect(assigns(:next_action)).to eq(:medium_biz)

      expect(assigns(:blurb)).not_to be_nil
      expect(assigns(:kind_of_event)).not_to be_nil
      expect(assigns(:kind_of_event_icon)).to eq("")
      expect(assigns(:kind_of_event_description)).not_to be_nil
      expect(assigns(:no_events_message)).not_to be_nil
      expect(assigns(:event_type)).to be_in(User.default_categories_hash.keys)
    end
  end
end
