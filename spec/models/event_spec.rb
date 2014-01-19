# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  description          :string(255)
#  starts_at            :date
#  ends_at              :date
#  campaign_id          :integer
#  category_id          :integer
#  repetition_type      :string(255)
#  repetition_frequency :integer
#  on_sunday            :boolean
#  on_monday            :boolean
#  on_tuesday           :boolean
#  on_wednesday         :boolean
#  on_thursday          :boolean
#  on_friday            :boolean
#  on_saturday          :boolean
#  repetition_options   :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe Event do
  before (:each) do
    @category = FactoryGirl.create(:category)
    @attr = { 
      :description => "the description", 
      :starts_at => "2/12/2012", 
      :ends_at => "2/12/2012", 
      :category => @category, 
      :repetition_type => "weekly", 
      :on_sunday => true 
    }
    @event = Event.new(@attr)
  end

  specify { Event.new(@attr).should be_valid }
  specify { Event.new(@attr).should respond_to(:edit_url) }
  specify { Event.new(@attr).should respond_to(:description) }
  specify { Event.new(@attr).should respond_to(:starts_at) }
  specify { Event.new(@attr).should respond_to(:ends_at) }
  specify { Event.new(@attr).should respond_to(:events_for_timeframe) }
  
  subject { @event }
  
  it { should be_valid }
  
  
  it "should require a description" do
    ev = Event.new(@attr.merge(:description => ""))
    ev.should_not be_valid
  end
  
  it "should require a starts_at" do
    ev = Event.new(@attr.merge(:starts_at => nil))
    ev.should_not be_valid
  end
  
  it "should require a ends_at" do
    ev = Event.new(@attr.merge(:ends_at => nil))
    ev.should_not be_valid
  end
  
  it "should require starts_at precedes ends_at" do
    ev = Event.new(@attr.merge(:starts_at => "2/1/2012",:ends_at => "1/1/2012"))
    ev.should_not be_valid
  end

  it "should allow starts_at and ends_at to be equal" do
    ev = Event.new(@attr.merge(:starts_at => "2/1/2012",:ends_at => "2/1/2012"))
    ev.should be_valid
  end

  it "should not allow descriptions that are too long" do
    ev = Event.new(@attr.merge(:description => "a" * 151))
    ev.should_not be_valid
  end
  
  it "should have to belong to a category" do
    ev = Event.new(@attr.merge(:category_id => nil))
    ev.should_not be_valid
  end

  describe "when building events for timeframe" do
    before(:each) do
      @attr = { 
        :description => "the description", 
        :starts_at => Date.strptime("2/1/2014", "%m/%d/%Y"), 
        :ends_at => Date.strptime("2/28/2014", "%m/%d/%Y"), 
        :category => @category, 
        :repetition_type => "weekly", 
        :on_sunday => true 
      }

      @february_repeater = Event.new(@attr)
      @february_repeater.should be_valid
    end
    
    it "should create the correct number of events for a subset of weekly repeater timeframe" do
      from_date_as_int = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("2/16/2014", "%m/%d/%Y").to_time.to_i
      events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      events.count.should == 3
    end
    
    it "should create the correct number of events for a subset of weekly repeater timeframe" do
      from_date_as_int = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("3/16/2014", "%m/%d/%Y").to_time.to_i
      events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      events.count.should == 4
    end
    
    it "should not create any events for prior to its timeframe" do
      from_date_as_int = Date.strptime("1/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("1/31/2014", "%m/%d/%Y").to_time.to_i
      events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      events.count.should == 0
    end
    
    it "should not create any events for after to its timeframe" do
      from_date_as_int = Date.strptime("3/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("6/30/2014", "%m/%d/%Y").to_time.to_i
      events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      events.count.should == 0
    end
    
    ### it "should create the correct number of events for a monthly repeater"
    
  end
  
end
