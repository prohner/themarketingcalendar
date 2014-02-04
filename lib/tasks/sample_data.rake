namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.delete_all
    ColorScheme.delete_all
    
    color_schemes = []
    color_schemes << ColorScheme.create(name: "Light brown on brown", background:"#A75C56", foreground:"#F5C972")
    color_schemes << ColorScheme.create(name: "Brown on brown", background:"#AE695A", foreground:"#EAB06E")
    color_schemes << ColorScheme.create(name: "Light brown on dark brown", background:"#E89C84", foreground:"#F5C972")
    color_schemes << ColorScheme.create(name: "White on brown", background:"brown", foreground:"white")
    color_schemes << ColorScheme.create(name: "cs5", background:"slate", foreground:"white")

    color_schemes << ColorScheme.create(name: "Brown on green", background:"#90CA77", foreground:"#E48743")
    color_schemes << ColorScheme.create(name: "Brown on cyan", background:"#81C6DD", foreground:"#E48743")
    color_schemes << ColorScheme.create(name: "Dark brown on light brown", background:"#E9B64D", foreground:"#9E3B33")

    color_schemes << ColorScheme.create(name: "Gray on graphite", background:"#527578", foreground:"#84978F")
    color_schemes << ColorScheme.create(name: "Dark gray on light gray", background:"#ADA692", foreground:"#47423F")
    color_schemes << ColorScheme.create(name: "White on gray", background:"#B3B1B2", foreground:"#FFFFFF")

    color_schemes << ColorScheme.create(name: "Brown on slate", background:"#74A6BD", foreground:"#EB8540")
    color_schemes << ColorScheme.create(name: "Brown on graphite", background:"#7195A3", foreground:"#B06A3B")
    color_schemes << ColorScheme.create(name: "Dark gray on pale", background:"#D4E7ED", foreground:"#AB988B")

    color_schemes << ColorScheme.create(name: "Dark gray on brown", background:"#8D3A61", foreground:"#3E4957")
    color_schemes << ColorScheme.create(name: "White on brown", background:"#B04979", foreground:"#D9E6F7")
    color_schemes << ColorScheme.create(name: "White on light brown", background:"#C55186", foreground:"#FFFFFF")

    color_schemes << ColorScheme.create(name: "Green on brown", background:"#DD1E2F", foreground:"#218559")
    color_schemes << ColorScheme.create(name: "Gray on light brown", background:"#EBB035", foreground:"#D0C6B1")
    color_schemes << ColorScheme.create(name: "Graphite on cyan", background:"#06A2CB", foreground:"#192823")
    
    user_pr = User.create(email:"pr@TheMarketingCalendar.com", first_name: "Preston", last_name: "Rohner", password: "foobar", password_confirmation: "foobar", user_type: 1, status: "signed up")
    user_ya = User.create(email:"ya@TheMarketingCalendar.com", first_name: "Yves", last_name: "Accad", password: "foobar", password_confirmation: "foobar", user_type: 1, status: "signed up")

    user_pr.save
    user_ya.save
    
    create_sample_data_for_user(user_pr, color_schemes)
    create_sample_data_for_user(user_ya, color_schemes)
    
  end
end

def create_sample_data_for_user(user, cs)
  tag = user.email[0]
  # puts "our tag is #{tag}"

  sales_support = CategoryGroup.create(description: "Sales Support", color_scheme: cs[1], user: user)
  sales_promotion = Category.create(description: "Sales Promotions", color_scheme: cs[2])
  collateral = Category.create(description: "Collateral & Presentations", color_scheme: cs[3])

  sales_support.categories << sales_promotion
  sales_support.categories << collateral
  
  public_relations = CategoryGroup.create(description: "Public Relations", color_scheme: cs[4], user: user)
  special_events = Category.create(description: "Special Events & Sponsorships", color_scheme: cs[5])
  press_releases = Category.create(description: "Press Releases", color_scheme: cs[6])
  public_relations.categories << special_events
  public_relations.categories << press_releases

  interactive = CategoryGroup.create(description: "Interactive", color_scheme: cs[7], user: user)
  keyword = Category.create(description: "Keyword/Search", color_scheme: cs[8])
  site_ads = Category.create(description: "Site Targeted Ads", color_scheme: cs[9])
  auctions = Category.create(description: "Online Auctions/Stores", color_scheme: cs[10])
  classifieds = Category.create(description: "Online Directory Listings & Classifieds", color_scheme: cs[11])
  affiliates = Category.create(description: "Affiliate Programs", color_scheme: cs[12])
  social_media = Category.create(description: "Social Media - Twitter, Facebook, etc.", color_scheme: cs[13])
  blog = Category.create(description: "Blog/RSS", color_scheme: cs[14])
  email = Category.create(description: "Email", color_scheme: cs[15])
  website = Category.create(description: "Website Messaging", color_scheme: cs[16])
  podcast = Category.create(description: "Podcast", color_scheme: cs[17])
  mobile = Category.create(description: "Mobile", color_scheme: cs[18])
  
  interactive.categories << keyword
  interactive.categories << site_ads
  interactive.categories << auctions
  interactive.categories << classifieds
  interactive.categories << affiliates
  interactive.categories << social_media
  interactive.categories << blog
  interactive.categories << email
  interactive.categories << website
  interactive.categories << podcast
  interactive.categories << mobile

  advertising = CategoryGroup.create(description: "Advertising", color_scheme: cs[19], user: user)
  
  tv = Category.create(description: "TV", color_scheme: cs[0])
  radio = Category.create(description: "Radio", color_scheme: cs[1])
  print = Category.create(description: "Print", color_scheme: cs[2])
  outdoor = Category.create(description: "Outdoor", color_scheme: cs[3])
  advertising.categories << tv
  advertising.categories << radio
  advertising.categories << print
  advertising.categories << outdoor
  
  research = CategoryGroup.create(description: "Research", color_scheme: cs[4], user: user)
  customer_surveys = Category.create(description: "Customer Surveys", color_scheme: cs[5])
  advertising_effectiveness = Category.create(description: "#{tag}-Advertising Effectiveness", color_scheme: cs[6])
  research.categories << customer_surveys
  research.categories << advertising_effectiveness
  
  current_year = 2014
  current_month = 2
  last_day_of_month = 28

  e = Event.create(description:"Every Friday", starts_at: make_time(2014, 1, 17), ends_at: make_time(2014, 3, 31), repetition_type: "weekly", on_friday: true)
  sales_promotion.events << e

  e = Event.create(description:"Sales Promo (offer)", starts_at: make_time(2014, 1, 25), ends_at: make_time(current_year, current_month, 7))
  sales_promotion.events << e
  
  e = Event.create(description:"Product Brochures", starts_at: make_time(current_year, current_month, 10), ends_at: make_time(current_year, current_month, 17))
  collateral.events << e
  
  e = Event.create(description:"Industry Pres.", starts_at: make_time(current_year, current_month, 15), ends_at: make_time(current_year, current_month, 25))
  collateral.events << e
  
  e = Event.create(description:"Industry Conference", starts_at: make_time(current_year, current_month, 15), ends_at: make_time(current_year, current_month, 25))
  special_events.events << e
  
  e = Event.create(description:"Pre Conf", starts_at: make_time(current_year, current_month, 10), ends_at: make_time(current_year, current_month, 17))
  press_releases.events << e
  
  e = Event.create(description:"Post Conf", starts_at: make_time(current_year, current_month, 26), ends_at: make_time(current_year, current_month, last_day_of_month))
  press_releases.events << e
  
  e = Event.create(description:"Keyword/Search Advertising", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, last_day_of_month))
  keyword.events << e
  
  e = Event.create(description:"Promote Conference", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, 7))
  site_ads.events << e
  
  e = Event.create(description:"Online Auction & Stores", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, last_day_of_month))
  auctions.events << e
  
  e = Event.create(description:"Online Directory Listings & Classified", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, last_day_of_month))
  classifieds.events << e
  
  e = Event.create(description:"Affiliate Recruitment Incentive Program", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, last_day_of_month))
  affiliates.events << e
  
  e = Event.create(description:"Facebook Announce", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, 7))
  social_media.events << e
  
  e = Event.create(description:"Pre Conf Tweets", starts_at: make_time(current_year, current_month, 8), ends_at: make_time(current_year, current_month, 15))
  social_media.events << e
  
  e = Event.create(description:"Live Tweets", starts_at: make_time(current_year, current_month, 16), ends_at: make_time(current_year, current_month, 23))
  social_media.events << e
  
  e = Event.create(description:"Post Conf. Tweets", starts_at: make_time(current_year, current_month, 24), ends_at: make_time(current_year, current_month, last_day_of_month))
  social_media.events << e
  
  e = Event.create(description:"#{tag}-Visit us at conference & receive gift", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, 14))
  blog.events << e
  
  e = Event.create(description:"Daily Conf. Recap", starts_at: make_time(current_year, current_month, 16), ends_at: make_time(current_year, current_month, 23))
  blog.events << e
  
  e = Event.create(description:"Upcoming Sales Promo", starts_at: make_time(current_year, current_month, 24), ends_at: make_time(current_year, current_month, last_day_of_month))
  social_media.events << e
  
  e = Event.create(description:"#{tag}-Visit us at conference & receive free gift", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, 14))
  email.events << e
  
  e = Event.create(description:"Upcoming Sales Promo", starts_at: make_time(current_year, current_month, 24), ends_at: make_time(current_year, current_month, last_day_of_month))
  email.events << e
  
  e = Event.create(description:"Promo", starts_at: make_time(current_year, current_month, 24), ends_at: make_time(current_year, current_month, last_day_of_month))
  website.events << e
  
  e = Event.create(description:"Coupon", starts_at: make_time(current_year, current_month + 1, 1), ends_at: make_time(current_year, current_month + 1, 7))
  website.events << e
  
  e = Event.create(description:"Highlights", starts_at: make_time(current_year, current_month, 24), ends_at: make_time(current_year, current_month, last_day_of_month))
  podcast.events << e
  
  e = Event.create(description:"XYZ Campaign QR Code - product info", starts_at: make_time(current_year, current_month, 16), ends_at: make_time(current_year, current_month, last_day_of_month))
  mobile.events << e
  
  e = Event.create(description:"XYZ Campaign", starts_at: make_time(current_year, current_month, 16), ends_at: make_time(current_year, current_month, last_day_of_month))
  tv.events << e
  
  e = Event.create(description:"XYZ Campaign", starts_at: make_time(current_year, current_month, 16), ends_at: make_time(current_year, current_month, last_day_of_month))
  radio.events << e
  
  e = Event.create(description:"XYZ Campaign with QR Code", starts_at: make_time(current_year, current_month, 16), ends_at: make_time(current_year, current_month, last_day_of_month))
  print.events << e
  
  e = Event.create(description:"Survey", starts_at: make_time(current_year, current_month, 8), ends_at: make_time(current_year, current_month, 23))
  customer_surveys.events << e
  
  e = Event.create(description:"Campaign Analysis", starts_at: make_time(current_year, current_month, 1), ends_at: make_time(current_year, current_month, last_day_of_month))
  advertising_effectiveness.events << e

end

def make_time(y, m, d)
  Time.utc(y, m, d)
end
