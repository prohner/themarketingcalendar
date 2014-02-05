namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.delete_all
    ColorScheme.delete_all
    
    color_schemes = []
    color_schemes << ColorScheme.create(name: "Light brown on brown", background:"#A75C56", foreground:"#E4D861")
    color_schemes << ColorScheme.create(name: "Brown on brown", background:"#AE695A", foreground:"#EAB06E")
    color_schemes << ColorScheme.create(name: "Light brown on dark brown", background:"#E89C84", foreground:"rgb(220, 220, 220)")
    color_schemes << ColorScheme.create(name: "White on brown", background:"brown", foreground:"rgb(220, 220, 220)")
    color_schemes << ColorScheme.create(name: "cs5", background:"slate", foreground:"rgb(220, 220, 220)")

    color_schemes << ColorScheme.create(name: "Brown on green", background:"#90CA77", foreground:"rgb(50, 50, 50)")
    color_schemes << ColorScheme.create(name: "Brown on cyan", background:"#81C6DD", foreground:"rgb(50, 50, 50)")
    color_schemes << ColorScheme.create(name: "Dark brown on light brown", background:"#E9B64D", foreground:"#9E3B33")

    color_schemes << ColorScheme.create(name: "Gray on graphite", background:"#527578", foreground:"rgb(220, 220, 220)")
    color_schemes << ColorScheme.create(name: "Dark gray on light gray", background:"#ADA692", foreground:"#47423F")
    color_schemes << ColorScheme.create(name: "White on gray", background:"#B3B1B2", foreground:"#FFFFFF")

    color_schemes << ColorScheme.create(name: "Brown on slate", background:"#74A6BD", foreground:"rgb(50, 50, 50)")
    color_schemes << ColorScheme.create(name: "Brown on graphite", background:"#7195A3", foreground:"rgb(50, 50, 50)")
    color_schemes << ColorScheme.create(name: "Dark gray on pale", background:"#D4E7ED", foreground:"#AB988B")

    color_schemes << ColorScheme.create(name: "Dark gray on brown", background:"#8D3A61", foreground:"rgb(220, 220, 220)")
    color_schemes << ColorScheme.create(name: "White on brown", background:"#B04979", foreground:"#D9E6F7")
    color_schemes << ColorScheme.create(name: "White on light brown", background:"#C55186", foreground:"#FFFFFF")

    color_schemes << ColorScheme.create(name: "Green on brown", background:"#DD1E2F", foreground:"#218559")
    color_schemes << ColorScheme.create(name: "Gray on light brown", background:"#EBB035", foreground:"#D0C6B1")
    color_schemes << ColorScheme.create(name: "Graphite on cyan", background:"#06A2CB", foreground:"#192823")
    
    user_pr = User.create(email:"pr@TheMarketingCalendar.com", first_name: "Preston", last_name: "Rohner", password: "foobar", password_confirmation: "foobar", user_type: 1, status: "signed up")
    user_ya = User.create(email:"ya@TheMarketingCalendar.com", first_name: "Yves", last_name: "Accad", password: "foobar", password_confirmation: "foobar", user_type: 1, status: "signed up")
    user_gr = User.create(email:"gr@TheMarketingCalendar.com", first_name: "Gerb", last_name: "Rockstar", password: "foobar", password_confirmation: "foobar", user_type: 1, status: "signed up")

    user_pr.save
    user_ya.save
    
    create_sample_data_for_user(user_pr, color_schemes)
    create_sample_data_for_user(user_ya, color_schemes)
    create_sample_email_calendars_for_user(user_pr, color_schemes)
    create_sample_email_calendars_for_user(user_ya, color_schemes)
  end
end

def create_sample_email_calendars_for_user(user, cs)
  gc_calendar = CategoryGroup.create(description: "Retail Business", color_scheme: cs[1], user: user)
  mf_calendar = CategoryGroup.create(description: "Online Business", color_scheme: cs[2], user: user)

  global = Category.create(description: "Global", color_scheme: cs[3])
  local_events = Category.create(description: "Local Events", color_scheme: cs[4])
  crm = Category.create(description: "CRM", color_scheme: cs[5])
  mms = Category.create(description: "MMS", color_scheme: cs[6])
  other = Category.create(description: "Other", color_scheme: cs[7])
  insights = Category.create(description: "Insights", color_scheme: cs[8])
  
  gc_calendar.categories << global
  gc_calendar.categories << local_events
  gc_calendar.categories << crm
  gc_calendar.categories << mms
  gc_calendar.categories << other
  gc_calendar.categories << insights

  regular = Category.create(description: "Regular", color_scheme: cs[9])
  survey = Category.create(description: "Survey", color_scheme: cs[10])
  mf_calendar.categories << regular
  mf_calendar.categories << survey
  
  current_year = 2014
  current_month = 2
  last_day_of_month = 28
  
  survey.events       << create_one_day_event("MF Panel Recruit Survey", current_year, current_month, 22)
  regular.events      << create_one_day_event("Value Props + Last Day for Winter Clearance (8033)", current_year, current_month - 1, 31)
  regular.events      << create_one_day_event("Welcome to The HUB - Launch & Sign Up & Band of the Month (7990) -Include Low-Responders", current_year, current_month, 2)
  regular.events      << create_one_day_event("British Invasion Sweeps (8384) -Include Low-Responders", current_year, current_month, 4)
  regular.events      << create_one_day_event("Gibson 2014 Sweeps (8385)", current_year, current_month, 6)
  regular.events      << create_one_day_event("The British Invasion is Here (8386)", current_year, current_month, 9)
  regular.events      << create_one_day_event("Merch Segmented + 12 Month Financing (TBD) -Include Low-Responders", current_year, current_month, 12)
  regular.events      << create_one_day_event("President's Day Celebration Starts Now (8387) -Include Low-Responders -Include Non-Responders", current_year, current_month, 14)
  regular.events      << create_one_day_event("British Invasion Sweeps + Gibson Sweeps + Merch Related Promos + Pres Day Coupon (8404)", current_year, current_month, 15)
  regular.events      << create_one_day_event("Presidents' Day Celebration (8408) -Include Low-Responders", current_year, current_month, 17)
  regular.events      << create_one_day_event("Merch Segmented (TBD) -Include Low-Responders", current_year, current_month, 18)
  regular.events      << create_one_day_event("PRG GOW Sign-Up (8032) -Guitar Segment -PRG List", current_year, current_month, 22)
  regular.events      << create_one_day_event("60th Anniversary Sweeps & Last Day for BOTH Sweeps (8401)", current_year, current_month, 24)
  regular.events      << create_one_day_event("Merch Segmented + Digital Catalog (TBD) -Include Low-Responders", current_year, current_month, 25)
  regular.events      << create_one_day_event("This Month on the Hub (TBD) -Include Low-Responders -Include Non-Responders", current_year, current_month, 27)
  regular.events      << create_one_day_event("Close Out Your Wishlist (TBD)", current_year, current_month, 28)

  crm.events          << create_one_day_event("CRM: Bounceback", current_year, current_month - 1, 27)
  crm.events          << create_one_day_event("CRM: Rentals (2) - Include Low Responders", current_year, current_month - 1, 28)
  crm.events          << create_one_day_event("CRM: String Club", current_year, current_month, 2)
  crm.events          << create_one_day_event("CRM: Stick Club", current_year, current_month, 2)
  crm.events          << create_one_day_event("CRM: Expired String Club", current_year, current_month, 3)
  crm.events          << create_one_day_event("CRM: Rentals (3) - Include Low Responders", current_year, current_month, 4)
  crm.events          << create_one_day_event("CRM: Rentals (1) - Include Low Responders", current_year, current_month, 11)
  crm.events          << create_one_day_event("CRM: Rentals (2) - Include Low Responders", current_year, current_month, 18)
  crm.events          << create_one_day_event("CRM: Rentals (6) - Include Low Responders", current_year, current_month, 25)
  crm.events          << create_one_day_event("CRM: String Club", current_year, current_month + 1, 2)
  crm.events          << create_one_day_event("CRM: Stick Club", current_year, current_month + 1, 2)
  
  crm.events          << create_one_day_event("CRM: Winback & In Cycle", current_year, current_month, 1)
  crm.events          << create_one_day_event("CRM: Friends and Family", current_year, current_month, 1)
  crm.events          << create_one_day_event("CRM: GC Price Tracker", current_year, current_month, 1)
  
  crm.events          << create_one_day_event("CRM: Winback & In Cycle", current_year, current_month + 1, 1)
  crm.events          << create_one_day_event("CRM: Friends and Family", current_year, current_month + 1, 1)
  crm.events          << create_one_day_event("CRM: GC Price Tracker", current_year, current_month + 1, 1)
  
  local_events.events << create_one_day_event("Local Events (4) - Include Low Responders", current_year, current_month - 1, 28)
  local_events.events << create_one_day_event("Local Events (5) - Include Low Responders", current_year, current_month, 4)
  local_events.events << create_one_day_event("Local Events (2)", current_year, current_month, 6)
  local_events.events << create_one_day_event("Local Events (3) - Include Low Responders", current_year, current_month, 11)
  local_events.events << create_one_day_event("Local Events (1)", current_year, current_month, 13)
  local_events.events << create_one_day_event("Local Events (6) - Include Low Responders", current_year, current_month, 18)
  local_events.events << create_one_day_event("Local Events (1)", current_year, current_month, 20)
  local_events.events << create_one_day_event("Local Events (11) - Include Low Responders", current_year, current_month, 25)
  local_events.events << create_one_day_event("Local Events (1)", current_year, current_month, 27)
  
  insights.events     << create_one_day_event("CI: Sales Circ Survey", current_year, current_month - 1, 27)
  insights.events     << create_one_day_event("CI: Census Survey Invite 3 (600K 12M Purch.)", current_year, current_month, 2)
  insights.events     << create_one_day_event("CI: Census Survey eCerts 2 (include outstanding invite 1 respondents)", current_year, current_month, 9)
  insights.events     << create_one_day_event("CI: Census Survey Invite 4 (600K 12M Purch.)", current_year, current_month, 16)
  insights.events     << create_one_day_event("CI: Census Survey eCerts 3", current_year, current_month, 23)
  insights.events     << create_one_day_event("CI: Census Survey Invite 5 (600K 12M Purch.)", current_year, current_month + 1, 2)

  mms.events          << create_one_day_event("MMS (2) -Include Low Responders", current_year, current_month - 1, 28)
  mms.events          << create_one_day_event("MMS (3) -Include Low Responders", current_year, current_month, 4)
  mms.events          << create_one_day_event("MMS (4) -Include Low Responders", current_year, current_month, 11)
  mms.events          << create_one_day_event("MMS (4) -Include Low Responders", current_year, current_month, 18)
  mms.events          << create_one_day_event("MMS (3) -Include Low Responders", current_year, current_month, 25)

  global.events       << create_one_day_event("Flash Deals", current_year, current_month - 1, 29)
  global.events       << create_one_day_event("Flash Deals", current_year, current_month, 5)
  global.events       << create_one_day_event("Flash Deals", current_year, current_month, 12)
  global.events       << create_one_day_event("Flash Deals", current_year, current_month, 19)
  global.events       << create_one_day_event("Flash Deals", current_year, current_month, 26)

  global.events       << create_one_day_event("Guitar Care Email Acoustic", current_year, current_month, 5)
  global.events       << create_one_day_event("Guitar Care Email Electric", current_year, current_month, 5)

  global.events       << create_one_day_event("50th Kickoff - Include Low Responders", current_year, current_month - 1, 30)
  global.events       << create_one_day_event("50th Kickoff San Ysidro", current_year, current_month - 1, 30)
  global.events       << create_one_day_event("50th Kickoff Dallas", current_year, current_month - 1, 30)
  global.events       << create_one_day_event("50th Kickoff Atlanta", current_year, current_month - 1, 30)
  global.events       << create_one_day_event("GC Pro Vocal Chain", current_year, current_month - 1, 30)


  global.events       << create_one_day_event("New and Exclusive - Include Low Responders", current_year, current_month, 6)
  global.events       << create_one_day_event("New and Exclusive San Ysidro", current_year, current_month, 6)
  global.events       << create_one_day_event("New and Exclusive Dallas", current_year, current_month, 6)
  global.events       << create_one_day_event("New and Exclusive Atlanta", current_year, current_month, 6)
  global.events       << create_one_day_event("GC Pro New and Exclusive", current_year, current_month, 6)

  global.events       << create_one_day_event("President's Day Sale - Include Low Responders - Include Non Responders", current_year, current_month, 13)
  global.events       << create_one_day_event("President's Day Sale San Ysidro", current_year, current_month, 13)
  global.events       << create_one_day_event("President's Day Sale Dallas", current_year, current_month, 13)
  global.events       << create_one_day_event("President's Day Sale Atlanta", current_year, current_month, 13)
  global.events       << create_one_day_event("GC Pro President's Day Sale", current_year, current_month, 13)

  global.events       << create_one_day_event("$29 Accessory Sale - Include Low Responders", current_year, current_month, 20)
  global.events       << create_one_day_event("$29 Accessory Sale San Ysidro", current_year, current_month, 20)
  global.events       << create_one_day_event("$29 Accessory Sale Dallas", current_year, current_month, 20)
  global.events       << create_one_day_event("$29 Accessory Sale Atlanta", current_year, current_month, 20)
  global.events       << create_one_day_event("GC Pro Monitors/Monitoring", current_year, current_month, 20)

  global.events       << create_one_day_event("Green Tag (elixir sub) PC Test - Include Low Responders", current_year, current_month, 27)
  global.events       << create_one_day_event("Green Tag San Ysidro", current_year, current_month, 27)
  global.events       << create_one_day_event("Green Tag Dallas", current_year, current_month, 27)
  global.events       << create_one_day_event("Green Tag Atlanta", current_year, current_month, 27)
  global.events       << create_one_day_event("GC Pro Green Tag", current_year, current_month, 27)

  global.events       << create_one_day_event("GC Newsletter", current_year, current_month - 1, 31)
  global.events       << create_one_day_event("GC Newsletter", current_year, current_month, 7)
  global.events       << create_one_day_event("GC Newsletter", current_year, current_month, 14)
  global.events       << create_one_day_event("GC Newsletter", current_year, current_month, 21)
  global.events       << create_one_day_event("GC Newsletter", current_year, current_month, 28)

  global.events       << create_one_day_event("Buyer's Guide", current_year, current_month, 1)
  global.events       << create_one_day_event("Buyer's Guide", current_year, current_month, 15)

  global.events       << create_one_day_event("Pedal Month Launch", current_year, current_month + 1, 1)

end

def create_one_day_event(title, year, month, day)
  Event.create(description: title, starts_at: make_time(year, month, day), ends_at: make_time(year, month, day))
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
