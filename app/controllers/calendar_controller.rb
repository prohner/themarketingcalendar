class CalendarController < ApplicationController
  before_action :authenticate_user! #, only: [:show, :edit, :update, :destroy]

  def index
    @event = Event.new
    # @categories = current_user.all_categories
    puts current_user.inspect
    @calendars = current_user.all_category_groups
  end

  def events
    puts "Calling CalendarController#events"
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    puts params.inspect

    start_date_int = params[:start]
    end_date_int = params[:end]
    
    start_date_int ||= 1.month.ago.to_i
    end_date_int ||= 1.month.from_now.to_i
    
    puts "Going from #{start_date_int} to #{end_date_int}"
    @events = current_user.all_events_in_timeframe(start_date_int, end_date_int)
    
    puts "Returning #{@events.count} events"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  def update_hidden_category_flag
    category_id = params[:id]
    puts "Hunting category id #{category_id} (#{Category.find(category_id).inspect})"
    
    current_user.toggle_viewing_category(Category.find(category_id))
    
    respond_to do |format|
      format.js  { render :json => nil }
    end
  end
  
  def stakeholder_interest
    puts params.inspect
    event = Event.find(params[:id])
    reminder_notification_days = params[:days]
    
    Stakeholder.create(:event => event, :user => current_user, :reminder_notification_days => reminder_notification_days)
  end
  
  private
    def category_params
      params.require(:id)
    end
  
end
