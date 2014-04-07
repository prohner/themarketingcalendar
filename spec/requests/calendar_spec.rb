require 'spec_helper'

describe "Calendar" do
  describe "GET /calendar/index" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)
      sign_in @dave
    end
    
    it "should return a page successfully" do
      get calendar_index_path
      follow_redirect!
      expect(response.status).to eq(200)
      
    end
  end
end
