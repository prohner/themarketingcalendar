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
    puts "RETURNING EVENTS"
    puts @events.inspect
    puts "RETURNING EVENTS DONE"
  end
  
  def facebook_add
  end
  
  def event_add
    
  end
end
