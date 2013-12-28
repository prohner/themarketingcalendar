class CalendarController < ApplicationController
  def index
    @event = Event.new
  end

  def events
    puts "Calling CalendarController#events"
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    puts params.inspect
    
    user_id = params[:id] || current_user.id
    #puts "request.url=#{request.url}"
    #puts "studio_id = #{studio_id}, params['id'] = #{params[:id]}, current_studio = #{current_studio}"
    
    raise ActionController::RoutingError.new("User missing") if user_id.blank? || User.find(user_id).nil?
    
    @event  = Event.new
    @events = Event.all
    # @events = @events.after(params['start']) if (params['start'])
    # @events = @events.before(params['end']) if (params['end'])
    # @events = @events.user_id(user_id) if (user_id)
    
    # @events.each do |event|
    #   event.edit_url = edit_event_path(event)
    # end
    
    puts "Sending back #{@events.count} records"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  def repeating_events
  end
end
