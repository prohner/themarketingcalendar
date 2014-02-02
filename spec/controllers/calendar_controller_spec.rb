require 'spec_helper'

describe CalendarController do

  describe "GET 'index'" do
    subject { get 'index' }
    
    it "redirect to signin path" do
      expect(subject).to redirect_to(new_user_session_path)
    end

    
    it "should return user's categories in alphabetical order"
    # it "should return user's categories in alphabetical order" do
    #   @bill = FactoryGirl.create(:user_bill)
    #   get 'index'
    #   categories = assigns(:categories)
    #   puts
    #   expect(categories).to eq (2)
    # end
  end

  describe "GET 'events'" do
    subject { get 'events' }

    it "returns http success" do
      expect(subject).to redirect_to(new_user_session_path)
    end
  end

  it "should respond to update_hidden_category_flag when user is logged in and save data "

  it "should verify that the controller assigns the right variables"
  # # describe "GET 'events'" do
  # #   before(:each) do
  # #     @dave = FactoryGirl.create(:user_dave)
  # #     sign_in @dave
  # #   end
  # # end
  # 
  # describe "when signed in" do
  #   before(:each) do
  #     @bill = FactoryGirl.create(:user_bill)
  #     @dave = FactoryGirl.create(:user_dave)
  #     sign_in @dave
  #     get 'events'
  #   end
  #   
  #   it "should render template when logged in" do
  #     response.should render_template :index
  #   end
  # 
  #   # it "should have the right number of events" do
  #   #   sign_in @dave
  #   #   get 'events.js'
  #   #   events = assigns(:events)
  #   #   puts "Dave's count: #{@dave.all_events.count}"
  #   #   puts "All count = #{events.count}"
  #   #   expect(assigns(:events)).to eq(@dave.all_events)
  #   # end
  # end
end
