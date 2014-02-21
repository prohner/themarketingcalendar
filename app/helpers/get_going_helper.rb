module GetGoingHelper
  
  def summary_page_for_category(category)
    raise "Symbol #{category} not found in User.default_categories_hash.keys" unless User.default_categories_hash.keys.include? category
    
    destination = ""
    case category
    when :twitter
      destination = get_going_twitter_add_path
    when :facebook
      destination = get_going_facebook_add_path
    when :google_plus
      destination = get_going_google_plus_add_path
    when :instagram
      destination = get_going_instagram_add_path
    when :pinterest
      destination = get_going_pinterest_add_path
    when :google_search
      destination = get_going_search_engine_add_path
    when :facebook_ads
      destination = get_going_facebook_ad_add_path
    when :blogging
      destination = get_going_blogging_add_path
    when :podcasting
      destination = get_going_podcasting_add_path
    when :webinars
      destination = get_going_webinar_add_path
    when :email
      destination = get_going_email_add_path
    when :direct_mail
      destination = get_going_direct_mail_add_path
    when :trade_shows
      destination = get_going_trade_show_add_path
    end
    
    destination
  end
end
