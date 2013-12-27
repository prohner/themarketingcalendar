namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    Company.delete_all
    User.delete_all
    
    company = Company.create(name: "The Company")
    
    user_pr = User.create(email:"pr@TheMarketingCalendar.com", first_name: "Preston", last_name: "Rohner", password: "foobar", password_confirmation: "foobar")
    user_ya = User.create(email:"ya@TheMarketingCalendar.com", first_name: "Yves", last_name: "Accad", password: "foobar", password_confirmation: "foobar")
    company.users << user_pr
    company.users << user_ya
    # user_pr.save
    # user_ya.save
    # company.save
    
    sales_support = CategoryGroup.create(description: "Sales Support", color: "#ff0000")
    sales_promotion = Category.create(description: "Sales Promotions", color: "#aa0000")
    collateral = Category.create(description: "Collateral & Presentations", color: "#0aa000")
    sales_support.categories << sales_promotion
    sales_support.categories << collateral
    
    public_relations = CategoryGroup.create(description: "Public Relations", color: "#00ff00")
    special_events = Category.create(description: "Special Events & Sponsorships", color: "#00aa00")
    press_releases = Category.create(description: "Press Releases", color: "#00aa00")
    public_relations.categories << special_events
    public_relations.categories << press_releases

    interactive = CategoryGroup.create(description: "Interactive", color: "#0000ff")
    keyword = Category.create(description: "Keyword/Search", color: "#0000aa")
    site_ads = Category.create(description: "Site Targeted Ads", color: "#0000aa")
    auctions = Category.create(description: "Online Auctions/Stores", color: "#0000aa")
    classifieds = Category.create(description: "Online Directory Listings & Classifieds", color: "#0000aa")
    affiliates = Category.create(description: "Affiliate Programs", color: "#0000aa")
    social_media = Category.create(description: "Social Media - Twitter, Facebook, etc.", color: "#0000aa")
    blog = Category.create(description: "Blog/RSS", color: "#0000aa")
    email = Category.create(description: "Email", color: "#0000aa")
    website = Category.create(description: "Website Messaging", color: "#0000aa")
    podcast = Category.create(description: "Podcast", color: "#0000aa")
    mobile = Category.create(description: "Mobile", color: "#0000aa")
    
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

    advertising = CategoryGroup.create(description: "Advertising", color: "#000ff0")
    tv = Category.create(description: "TV", color: "#000aa00")
    radio = Category.create(description: "Radio", color: "#000aa00")
    print = Category.create(description: "Print", color: "#000aa00")
    outdoor = Category.create(description: "Outdoor", color: "#000aa00")
    advertising.categories << tv
    advertising.categories << radio
    advertising.categories << print
    advertising.categories << outdoor
    
    research = CategoryGroup.create(description: "Research", color: "#0ff000")
    customer_surveys = Category.create(description: "Customer Surveys", color: "#0aa000")
    advertising_effectiveness = Category.create(description: "Advertising Effectiveness", color: "#0aa000")
    research.categories << customer_surveys
    research.categories << advertising_effectiveness

    campaign_1 = Campaign.create(description:"Campaign 1", color: "red", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 7) )
    campaign_2 = Campaign.create(description:"Campaign 2", color: "green", starts_at: make_time(2014, 1, 8), ends_at: make_time(2014, 1, 15) )
    
    e = Event.create(description:"Sales Promo (offer)", starts_at: make_time(2014, 1, 25), ends_at: make_time(2014, 2, 1))
    sales_promotion.events << e
    campaign_1.events << e

    e = Event.create(description:"Product Brochures", starts_at: make_time(2014, 1, 10), ends_at: make_time(2014, 1, 17))
    collateral.events << e
    campaign_1.events << e

    e = Event.create(description:"Industry Pres.", starts_at: make_time(2014, 1, 15), ends_at: make_time(2014, 1, 25))
    collateral.events << e
    campaign_1.events << e

    e = Event.create(description:"Industry Conference", starts_at: make_time(2014, 1, 15), ends_at: make_time(2014, 1, 25))
    special_events.events << e
    campaign_2.events << e

    e = Event.create(description:"Pre Conf", starts_at: make_time(2014, 1, 10), ends_at: make_time(2014, 1, 17))
    press_releases.events << e
    campaign_1.events << e

    e = Event.create(description:"Post Conf", starts_at: make_time(2014, 1, 26), ends_at: make_time(2014, 1, 31))
    press_releases.events << e
    campaign_1.events << e

    e = Event.create(description:"Keyword/Search Advertising", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    keyword.events << e
    campaign_2.events << e

    e = Event.create(description:"Promote Conference", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 7))
    site_ads.events << e
    campaign_1.events << e

    e = Event.create(description:"Online Auction & Stores", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    auctions.events << e
    campaign_2.events << e

    e = Event.create(description:"Online Directory Listings & Classified", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    classifieds.events << e
    campaign_2.events << e

    e = Event.create(description:"Affiliate Recruitment Incentive Program", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    affiliates.events << e
    campaign_2.events << e

    e = Event.create(description:"Facebook Announce", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 7))
    social_media.events << e
    campaign_1.events << e

    e = Event.create(description:"Pre Conf Tweets", starts_at: make_time(2014, 1, 8), ends_at: make_time(2014, 1, 15))
    social_media.events << e
    campaign_1.events << e

    e = Event.create(description:"Live Tweets", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 23))
    social_media.events << e
    campaign_1.events << e

    e = Event.create(description:"Post Conf. Tweets", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    social_media.events << e
    campaign_1.events << e

    e = Event.create(description:"Visit us at conference & receive free gift", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 14))
    blog.events << e
    campaign_1.events << e

    e = Event.create(description:"Daily Conf. Recap", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 23))
    blog.events << e
    campaign_1.events << e

    e = Event.create(description:"Upcoming Sales Promo", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    social_media.events << e
    campaign_1.events << e

    e = Event.create(description:"Visit us at conference & receive free gift", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 14))
    email.events << e
    campaign_1.events << e

    e = Event.create(description:"Upcoming Sales Promo", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    email.events << e
    campaign_1.events << e

    e = Event.create(description:"Promo", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    website.events << e
    campaign_1.events << e

    e = Event.create(description:"Coupon", starts_at: make_time(2014, 2, 1), ends_at: make_time(2014, 2, 7))
    website.events << e
    campaign_1.events << e

    e = Event.create(description:"Highlights", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    podcast.events << e
    campaign_1.events << e

    e = Event.create(description:"XYZ Campaign QR Code - product info", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 31))
    mobile.events << e
    campaign_1.events << e

    e = Event.create(description:"XYZ Campaign", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 31))
    tv.events << e
    campaign_2.events << e

    e = Event.create(description:"XYZ Campaign", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 31))
    radio.events << e
    campaign_2.events << e

    e = Event.create(description:"XYZ Campaign with QR Code", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 31))
    print.events << e
    campaign_2.events << e

    e = Event.create(description:"Survey", starts_at: make_time(2014, 1, 8), ends_at: make_time(2014, 1, 23))
    customer_surveys.events << e
    campaign_2.events << e

    e = Event.create(description:"Campaign Analysis", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    advertising_effectiveness.events << e
    campaign_2.events << e


    e = Event.create(description:"Campaign Analysis", starts_at: make_time(2013, 12, 1), ends_at: make_time(2013, 12, 6))
    advertising_effectiveness.events << e
    campaign_2.events << e

    e = Event.create(description:"Survey", starts_at: make_time(2013, 12, 5), ends_at: make_time(2013, 12, 8))
    advertising_effectiveness.events << e
    campaign_2.events << e
  end
end

def make_time(y, m, d)
  Time.utc(y, m, d)
end
