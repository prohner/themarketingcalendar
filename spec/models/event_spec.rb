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
#  notes                :string(255)
#

require 'spec_helper'

describe Event do
  let(:category)  { FactoryGirl.create(:category) }
  let(:attr)      { { 
                    :description => "the description", 
                    :starts_at => "2/12/2012", 
                    :ends_at => "2/12/2012", 
                    :category => category, 
                    :repetition_type => :none, 
                    :on_sunday => true 
                  } }
  subject(:event) { Event.new(attr) }
  
  it { should be_valid }
  it { should respond_to(:edit_url) }
  it { should respond_to(:description) }
  it { should respond_to(:starts_at) }
  it { should respond_to(:ends_at) }
  it { should respond_to(:events_for_timeframe) }
  it { should respond_to(:repeating_event?) }
  it { should respond_to(:number_of_days_until_event_starts) }
    
  it "should require a description" do
    ev = Event.new(attr.merge(:description => ""))
    expect(ev).not_to be_valid
  end
  
  it "should require a starts_at" do
    ev = Event.new(attr.merge(:starts_at => nil))
    expect(ev).not_to be_valid
  end
  
  it "should require a ends_at" do
    ev = Event.new(attr.merge(:ends_at => nil))
    expect(ev).not_to be_valid
  end
  
  it "should insert a default repetition_type" do
    ev = Event.new(attr.merge(:repetition_type => nil))
    expect(ev).to be_valid
  end
  
  it "should require starts_at precedes ends_at" do
    ev = Event.new(attr.merge(:starts_at => "2/1/2014",:ends_at => "1/1/2014"))
    expect(ev).not_to be_valid
  end
  
  it "should allow starts_at and ends_at to be equal" do
    ev = Event.new(attr.merge(:starts_at => "2/1/2014",:ends_at => "2/1/2014"))
    expect(ev).to be_valid
  end
  
  it "should not allow descriptions that are too long" do
    ev = Event.new(attr.merge(:description => "a" * 151))
    expect(ev).not_to be_valid
  end
  
  it "should not allow notes that are too long" do
    ev = Event.new(attr.merge(:notes => "a" * 251))
    expect(ev).not_to be_valid
  end
  
  it "should have to belong to a category" do
    ev = Event.new(attr.merge(:category_id => nil))
    expect(ev).not_to be_valid
  end
  
  describe "when changing repetition type" do
    it "should be valid with valid repetition types" do
      [:weekly, :biweekly, :monthly, :none].each do |freq|
        ev = Event.new(attr.merge(:repetition_type => freq))
        expect(ev).to be_valid
      end
    end
    
    it "should not be valid with invalid repetition types" do
      [:Xweekly, :Ymonthly, :Znone].each do |freq|
        ev = Event.new(attr.merge(:repetition_type => freq))
        expect(ev).not_to be_valid
      end
    end
    
    it "should answer :repeating_event? correctly" do
      ev = Event.new(attr)
  
      ev.repetition_type = :none
      expect(ev.repeating_event?).to be_falsey
  
      ev.repetition_type = :weekly
      expect(ev.repeating_event?).to be_truthy
  
      ev.repetition_type = :monthly
      expect(ev.repeating_event?).to be_truthy
    end
  end
  
  it "should return the list of repetition types exactly correctly" do
    expect(Event.list_of_repetition_type_options).to eq([:none, :weekly, :biweekly, :monthly])
  end

  describe "when building monthly events for timeframe" do
    before(:each) do
      @attr = { 
        :description => "the description", 
        :starts_at => Date.strptime("2/1/2014", "%m/%d/%Y"), 
        :ends_at => Date.strptime("5/15/2014", "%m/%d/%Y"), 
        :category => category, 
        :repetition_type => :monthly, 
        :on_sunday => true 
      }
  
      @monthly_repeater = Event.new(@attr)
      
      from_date_as_int = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("5/31/2014", "%m/%d/%Y").to_time.to_i
      @events = @monthly_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      
    end
    
    it "should be valid" do
      expect(@monthly_repeater).to be_valid
    end
    
    it "should repeat on the first of each month" do
      expect(@events.count).to eq(4)
    end
  
    it "should have each event set to one date" do
      @events.each do |e|
        expect(e.starts_at).to eq(e.ends_at)
      end
    end
      
    it "should have each day covered correctly" do
      expect(@events[0].starts_at).to eq(Date.strptime("2/1/2014", "%m/%d/%Y"))
      expect(@events[1].starts_at).to eq(Date.strptime("3/1/2014", "%m/%d/%Y"))
      expect(@events[2].starts_at).to eq(Date.strptime("4/1/2014", "%m/%d/%Y"))
      expect(@events[3].starts_at).to eq(Date.strptime("5/1/2014", "%m/%d/%Y"))
    end
    
    it "should create the correct number of events for a subset of weekly repeater timeframe" do
      from_date_as_int = Date.strptime("2/28/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("4/2/2014", "%m/%d/%Y").to_time.to_i
      events = @monthly_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      expect(events.count).to eq(2)
    end
    
    it "should not create any events for prior to its timeframe" do
      from_date_as_int = Date.strptime("1/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("1/31/2014", "%m/%d/%Y").to_time.to_i
      events = @monthly_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      expect(events.count).to eq(0)
    end
    
    it "should not create any events for after to its timeframe" do
      from_date_as_int = Date.strptime("5/2/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("8/31/2014", "%m/%d/%Y").to_time.to_i
      events = @monthly_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      expect(events.count).to eq(0)
    end
    
  end
  
  describe "when building weekly events for timeframe" do
    before(:each) do
      @attr = { 
        :description => "the description", 
        :starts_at => Date.strptime("2/1/2014", "%m/%d/%Y"), 
        :ends_at => Date.strptime("2/28/2014", "%m/%d/%Y"), 
        :category => category, 
        :repetition_type => :weekly, 
        :on_sunday => true 
      }
  
      @february_repeater = Event.new(@attr)
      expect(@february_repeater).to be_valid
      # @february_repeater.should be_valid
  
      from_date_as_int = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("2/16/2014", "%m/%d/%Y").to_time.to_i
      @events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
    end
  
    it "should create the correct number of events for a subset of weekly repeater timeframe" do
      expect(@events.count).to eq(3)
    end
      
    it "should have each event set to one date" do
      @events.each do |e|
        expect(e.starts_at).to eq(e.ends_at)
      end
    end
      
    it "should have each day covered correctly" do
      expect(@events[0].starts_at).to eq(Date.strptime("2/2/2014", "%m/%d/%Y"))
      expect(@events[1].starts_at).to eq(Date.strptime("2/9/2014", "%m/%d/%Y"))
      expect(@events[2].starts_at).to eq(Date.strptime("2/16/2014", "%m/%d/%Y"))
    end
    
    it "should create the correct number of events for a subset of weekly repeater timeframe" do
      from_date_as_int = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("3/16/2014", "%m/%d/%Y").to_time.to_i
      events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      expect(events.count).to eq(4)
    end
    
    it "should not create any events for prior to its timeframe" do
      from_date_as_int = Date.strptime("1/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("1/31/2014", "%m/%d/%Y").to_time.to_i
      events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      expect(events.count).to eq(0)
    end
    
    it "should not create any events for after to its timeframe" do
      from_date_as_int = Date.strptime("3/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("6/30/2014", "%m/%d/%Y").to_time.to_i
      events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      expect(events.count).to eq(0)
    end
    
    it "should create the repeating events starting on starts_at" do
      repeater = Event.new({ 
        :description => "the description", 
        :starts_at => Date.strptime("1/1/2014", "%m/%d/%Y"), 
        :ends_at => Date.strptime("3/31/2014", "%m/%d/%Y"), 
        :category => category, 
        :repetition_type => :weekly, 
        :on_wednesday => true 
      })
      expect(repeater).to be_valid
  
      from_date_as_int = Date.strptime("1/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("1/29/2014", "%m/%d/%Y").to_time.to_i
  
      events = repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      expect(events.count).to eq(5)
    end
  
    it "should create the right repeating events for an exact month" do
      repeater = Event.new({ 
        :description => "the description", 
        :starts_at => Date.strptime("2/1/2014", "%m/%d/%Y"), 
        :ends_at => Date.strptime("2/28/2014", "%m/%d/%Y"), 
        :category => category, 
        :repetition_type => :weekly, 
        :on_friday => true 
      })
      expect(repeater).to be_valid
  
      from_date_as_int = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
      to_date_as_int = Date.strptime("2/28/2014", "%m/%d/%Y").to_time.to_i
  
      events = repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      expect(events.count).to eq(4)
    end
  end

  describe "when building biweekly events for timeframe" do
    context "when handling a biweekly once-a-week event for Feb 2014" do
      before(:each) do
        @attr = { 
          :description => "the description", 
          :starts_at => Date.strptime("2/1/2014", "%m/%d/%Y"), 
          :ends_at => Date.strptime("2/28/2014", "%m/%d/%Y"), 
          :category => category, 
          :repetition_type => :biweekly, 
          :on_friday => true 
        }
  
        @february_repeater = Event.new(@attr)
        expect(@february_repeater).to be_valid
        # @february_repeater.should be_valid
  
        from_date_as_int = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
        to_date_as_int = Date.strptime("2/28/2014", "%m/%d/%Y").to_time.to_i
        @events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      end
    
      it "should create the correct number of events for a subset of biweekly repeater timeframe" do
        expect(@events.count).to eq(2)
      end
      
      it "should create the correct dates for events for biweekly repeater timeframe" do
        expect(@events[0].starts_at).to eq(Date.strptime("2/14/2014", "%m/%d/%Y"))
        expect(@events[1].starts_at).to eq(Date.strptime("2/28/2014", "%m/%d/%Y"))
      end
      
      it "should have each event set to one date" do
        @events.each do |e|
          expect(e.starts_at).to eq(e.ends_at)
        end
      end
    end
    
    context "when handling a biweekly few-times-a-week event for Feb 2014" do
      before(:each) do
        @attr = { 
          :description => "the description", 
          :starts_at => Date.strptime("2/1/2014", "%m/%d/%Y"), 
          :ends_at => Date.strptime("2/28/2014", "%m/%d/%Y"), 
          :category => category, 
          :repetition_type => :biweekly, 
          :on_monday => true,
          :on_wednesday => true,
          :on_friday => true
        }
  
        @february_repeater = Event.new(@attr)
        expect(@february_repeater).to be_valid
        # @february_repeater.should be_valid
  
        from_date_as_int = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
        to_date_as_int = Date.strptime("2/28/2014", "%m/%d/%Y").to_time.to_i
        @events = @february_repeater.events_for_timeframe(from_date_as_int, to_date_as_int)
      end
    
      it "should create the correct number of events for a subset of biweekly repeater timeframe" do
        expect(@events.count).to eq(6)
      end
      
      it "should create the correct dates for events for biweekly repeater timeframe" do
        expect(@events[0].starts_at).to eq(Date.strptime("2/10/2014", "%m/%d/%Y"))
        expect(@events[1].starts_at).to eq(Date.strptime("2/12/2014", "%m/%d/%Y"))
        expect(@events[2].starts_at).to eq(Date.strptime("2/14/2014", "%m/%d/%Y"))
        expect(@events[3].starts_at).to eq(Date.strptime("2/24/2014", "%m/%d/%Y"))
        expect(@events[4].starts_at).to eq(Date.strptime("2/26/2014", "%m/%d/%Y"))
        expect(@events[5].starts_at).to eq(Date.strptime("2/28/2014", "%m/%d/%Y"))
      end
      
      it "should have each event set to one date" do
        @events.each do |e|
          expect(e.starts_at).to eq(e.ends_at)
        end
      end
    end
    
  end
  
  describe "#number_of_days_until_event_starts" do 
    it "should handle a single day into the future" do
      start_date = Date.today + 1.day
      end_date = Date.today + 2.day
      ev = Event.new(attr.merge(:starts_at => start_date, :ends_at => end_date))
      expect(ev.number_of_days_until_event_starts).to eq(1)
    end
    
    it "should be return a negative when the event starts in the past" do
      start_date = Date.today - 2.days
      end_date = Date.today - 1.day
      ev = Event.new(attr.merge(:starts_at => start_date, :ends_at => end_date))
      expect(ev.number_of_days_until_event_starts).to eq(-2)
    end
    
    it "should work when passing a base comparison date" do
      base_comparison_date = Date.today + 1.day
      start_date = Date.today + 2.days
      end_date = Date.today + 3.days
      ev = Event.new(attr.merge(:starts_at => start_date, :ends_at => end_date))
      expect(ev.number_of_days_until_event_starts(base_comparison_date)).to eq(1)
    end
  end
end
