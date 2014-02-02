class CalendarController < ApplicationController
  before_action :authenticate_user! #, only: [:show, :edit, :update, :destroy]

  def index
    @event = Event.new
    @categories = current_user.all_categories
  end

  def events
    puts "Calling CalendarController#events"
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    puts params.inspect
    
    @events = current_user.all_events
    
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
  
  private
    def category_params
      params.require(:id)
    end
  
end
