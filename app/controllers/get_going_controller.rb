class GetGoingController < ApplicationController
  before_action :authenticate_user! #, only: [:show, :edit, :update, :destroy]

  def start
  end

  def home_biz
  end

  def small_biz
  end

  def medium_biz
    current_user.create_new_calendar_with_default_categories
    @event_counts = {
      :twitter => current_user.count_for_default_category(:twitter),
      :facebook => current_user.count_for_default_category(:facebook),
      :google_plus => current_user.count_for_default_category(:google_plus),
      :instagram => current_user.count_for_default_category(:instagram),
      :pinterest => current_user.count_for_default_category(:pinterest),
      :google_search => current_user.count_for_default_category(:google_search),
      :facebook_ads => current_user.count_for_default_category(:facebook_ads),
      :blogging => current_user.count_for_default_category(:blogging),
      :podcasting => current_user.count_for_default_category(:podcasting),
      :webinars => current_user.count_for_default_category(:webinars),
      :email => current_user.count_for_default_category(:email),
      :direct_mail => current_user.count_for_default_category(:direct_mail),
      :trade_shows => current_user.count_for_default_category(:trade_shows)
    }
  end

  def large_biz
  end
  
  def twitter_add
    @events = current_user.events_for_default_category(:twitter)
    @blurb = "You know that social media is important.  Let's take a minute to make some plans to keep your customers up to date."
    @event_type = :twitter
    @kind_of_event = "Twitter"
    @kind_of_event_icon = "twitter_icon.jpg"
    @kind_of_event_description = "With Twitter you may broadcast text-based messages to your diverse audience."
    @no_events_message = "You do not have any Twitter events planned.  But, hey, not everyone tweets.  It is a good way to keep your own brand in front of your customers."
    @next_action = :facebook_add
  end
  
  def facebook_add
    @events = current_user.events_for_default_category(:facebook)
    @blurb = "You know that social media is important.  Let's take a minute to make some plans to keep your customers up to date."
    @kind_of_event = "Facebook"
    @kind_of_event_icon = "facebook_icon.png"
    @kind_of_event_description = "Facebook's content-friendly format is terrific to post regular updates."
    @no_events_message = "You do not have any Facebook events planned.  Posting regularly to a Facebook page requires a little effort but the rewards can be worth it."
    @next_action = :facebook_add
    
    render 'twitter_add'
  end
  
  def event_add
    @event = Event.new
    
    unless params[:event_type].nil?
      event_type = params[:event_type].to_sym
      @event_type_text = User.default_categories_hash[event_type]
      category = current_user.category_from_default_calendar(event_type)
      @category_id = category.id
    end

  end
  
  def create_event
    @event = Event.new(event_params)
    @event.repetition_type = :none
    
    puts ""
    puts @event.inspect
    puts ""
    puts "repetition type = #{@event.repetition_type}"
    puts ""

    respond_to do |format|
      if @event.save
        format.html { redirect_to get_going_twitter_add_path, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        puts ""
        puts @event.errors.inspect
        puts ""
        format.html { redirect_to get_going_event_add_path(:event_type => params[:event_type]), error: 'Event could not be created.' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def event_params
      params.require(:event).permit(:description, :category_id, :starts_at, :ends_at, :category_id, :repetition_type, :repetition_frequency, :on_sunday, :on_monday, :on_tuesday, :on_wednesday, :on_thursday, :on_friday, :on_saturday, :repetition_options)
    end
  
end
