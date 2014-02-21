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
  
  def parameters_for_category(category_symbol)
    raise "Symbol #{category_symbol} not found in User.default_categories_hash.keys" unless User.default_categories_hash.keys.include? category_symbol
    
    events = current_user.events_for_default_category(category_symbol)
    
    next_action = nil
    case category_symbol
    when :twitter
      next_action = :facebook_add
    when :facebook
      next_action = :google_plus_add
    when :google_plus
      next_action = :instagram_add
    when :instagram
      next_action = :pinterest_add
    when :pinterest
      next_action = :search_engine_add
    when :google_search
      next_action = :facebook_ad_add
    when :facebook_ads
      next_action = :blogging_add
    when :blogging
      next_action = :podcasting_add
    when :podcasting
      next_action = :webinar_add
    when :webinars
      next_action = :email_add
    when :email
      next_action = :direct_mail_add
    when :direct_mail
      next_action = :trade_show_add
    when :trade_shows
      next_action = :medium_biz
    end
    
    return events, category_symbol, next_action
  end
  
  def twitter_add
    @events, @event_type, @next_action = parameters_for_category(:twitter)

    @blurb = "You know that social media is important.  Let's take a minute to make some plans to keep your customers up to date."
    @kind_of_event = "Twitter"
    @kind_of_event_icon = "twitter_icon.jpg"
    @kind_of_event_description = "With Twitter you may broadcast text-based messages to your diverse audience."
    @no_events_message = "You do not have any Twitter events planned.  But, hey, not everyone tweets.  It is a good way to keep your own brand in front of your customers."

    render 'event_overview'
  end
  
  def facebook_add
    @events, @event_type, @next_action = parameters_for_category(:facebook)

    @blurb = "You know that social media is important.  Let's take a minute to make some plans to keep your customers up to date."
    @kind_of_event = "Facebook"
    @kind_of_event_icon = "facebook_icon.png"
    @kind_of_event_description = "Facebook's content-friendly format is terrific to post regular updates."
    @no_events_message = "You do not have any Facebook events planned.  Posting regularly to a Facebook page requires a little effort but the rewards can be worth it."
    
    render 'event_overview'
  end
  
  def google_plus_add
    @events, @event_type, @next_action = parameters_for_category(:google_plus)

    @blurb = "You know that social media is important.  Let's take a minute to make some plans to keep your customers up to date."
    @kind_of_event = "Google+"
    @kind_of_event_icon = "google_plus_icon.jpg"
    @kind_of_event_description = "Google+ has more of a tech orientation but you can build authority and get your picture on Google search results."
    @no_events_message = "You do not have any Google+ events planned.  Expanding your presence while Google+ is growing could help establish you as an early authority."
    
    render 'event_overview'
  end
  
  def instagram_add
    @events, @event_type, @next_action = parameters_for_category(:instagram)

    @blurb = "You know that social media is important.  Let's take a minute to make some plans to keep your customers up to date."
    @kind_of_event = "Instagram"
    @kind_of_event_icon = "instagram_icon.jpg"
    @kind_of_event_description = "Now with tight Facebook integration and videos, Instagram is a good complement to Facebook."
    @no_events_message = "You do not have any Instagram events planned."
    
    render 'event_overview'
  end
  
  def pinterest_add
    @events, @event_type, @next_action = parameters_for_category(:pinterest)

    @blurb = ""
    @kind_of_event = "Pinterest"
    @kind_of_event_icon = "pinterest_icon.jpg"
    @kind_of_event_description = "Use your visual appeal to reach a predominantly female audience. Outstanding for traffic generation, especially for retail."
    @no_events_message = "You do not have any Pinterest events planned."
    
    render 'event_overview'
  end
  
  def search_engine_add
    @events, @event_type, @next_action = parameters_for_category(:google_search)

    @blurb = ""
    @kind_of_event = "Search Engine Marketing"
    @kind_of_event_icon = ""
    @kind_of_event_description = "Google is the big dog of search engine advertising, but Bing and Yahoo! offer similar services."
    @no_events_message = "You do not have any search engine events planned."
    
    render 'event_overview'
  end
  
  def facebook_ad_add
    @events, @event_type, @next_action = parameters_for_category(:facebook_ads)

    @blurb = ""
    @kind_of_event = "Facebook Advertising"
    @kind_of_event_icon = "facebook_icon.png"
    @kind_of_event_description = "Facebook does more than just provide space to share...run ads to highly targeted demographic and psychographic groups."
    @no_events_message = "You do not have any Facebook advertising planned."
    
    render 'event_overview'
  end
  
  def blogging_add
    @events, @event_type, @next_action = parameters_for_category(:blogging)

    @blurb = ""
    @kind_of_event = "Blogging/SEO"
    @kind_of_event_icon = ""
    @kind_of_event_description = "Creating new, interesting, and useful content helps improve your ranking in search engines."
    @no_events_message = "You do not have any blogging planned."
    
    render 'event_overview'
  end
  
  def podcasting_add
    @events, @event_type, @next_action = parameters_for_category(:podcasting)

    @blurb = ""
    @kind_of_event = "Podcasting"
    @kind_of_event_icon = ""
    @kind_of_event_description = "Podcasting enables you to engage with your customers."
    @no_events_message = "You do not have any podcasts planned."
    
    render 'event_overview'
  end
  
  def webinar_add
    @events, @event_type, @next_action = parameters_for_category(:webinars)

    @blurb = ""
    @kind_of_event = "Webinar"
    @kind_of_event_icon = ""
    @kind_of_event_description = "Webinars help you to position yourself as an expert in your domain."
    @no_events_message = "You do not have any webinars planned."
    
    render 'event_overview'
  end
  
  def email_add
    @events, @event_type, @next_action = parameters_for_category(:email)

    @blurb = ""
    @kind_of_event = "Email"
    @kind_of_event_icon = ""
    @kind_of_event_description = "Regular email campaigns help you develop an in-depth relationship with your customers."
    @no_events_message = "You do not have any email campaigns planned."
    
    render 'event_overview'
  end
  
  def direct_mail_add
    @events, @event_type, @next_action = parameters_for_category(:direct_mail)

    @blurb = ""
    @kind_of_event = "Direct Mail"
    @kind_of_event_icon = ""
    @kind_of_event_description = "A resource-intensive channel that generally yields some successes."
    @no_events_message = "You do not have any direct mail campaigns planned."
    
    render 'event_overview'
  end
  
  def trade_show_add
    @events, @event_type, @next_action = parameters_for_category(:trade_shows)

    @blurb = ""
    @kind_of_event = "Trade Show"
    @kind_of_event_icon = ""
    @kind_of_event_description = "Attending trade show events gives you face-to-face contact with your customers and/or distributors.  If you're a hail fellow well met then get out and press the flesh!"
    @no_events_message = "You do not have any trade show planned."
    
    render 'event_overview'
  end
  
  def event_add
    @event = Event.new
    
    unless params[:event_type].nil?
      @event_type = params[:event_type].to_sym
      @event_type_text = User.default_categories_hash[@event_type]
      category = current_user.category_from_default_calendar(@event_type)
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
        format.html { redirect_to summary_page_for_category(:twitter), notice: 'Event was successfully created.' }
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
