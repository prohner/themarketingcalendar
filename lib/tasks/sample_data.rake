namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.delete_all
    ColorScheme.delete_all
    
    cs1  = ColorScheme.create(background:"#A75C56", foreground:"#F5C972")
    cs2  = ColorScheme.create(background:"#AE695A", foreground:"#EAB06E")
    cs3  = ColorScheme.create(background:"#E89C84", foreground:"#F5C972")
    cs4  = ColorScheme.create(background:"brown", foreground:"white")
    cs5  = ColorScheme.create(background:"slate", foreground:"white")

    cs6  = ColorScheme.create(background:"#90CA77", foreground:"#E48743")
    cs7  = ColorScheme.create(background:"#81C6DD", foreground:"#E48743")
    cs8  = ColorScheme.create(background:"#E9B64D", foreground:"#9E3B33")

    cs9  = ColorScheme.create(background:"#527578", foreground:"#84978F")
    cs10 = ColorScheme.create(background:"#ADA692", foreground:"#47423F")
    cs11 = ColorScheme.create(background:"#B3B1B2", foreground:"#FFFFFF")

    cs12 = ColorScheme.create(background:"#74A6BD", foreground:"#EB8540")
    cs13 = ColorScheme.create(background:"#7195A3", foreground:"#B06A3B")
    cs14 = ColorScheme.create(background:"#D4E7ED", foreground:"#AB988B")

    cs15 = ColorScheme.create(background:"#8D3A61", foreground:"#3E4957")
    cs16 = ColorScheme.create(background:"#B04979", foreground:"#D9E6F7")
    cs17 = ColorScheme.create(background:"#C55186", foreground:"#FFFFFF")

    cs18 = ColorScheme.create(background:"#DD1E2F", foreground:"#218559")
    cs19 = ColorScheme.create(background:"#EBB035", foreground:"#D0C6B1")
    cs20 = ColorScheme.create(background:"#06A2CB", foreground:"#192823")
    
    user_pr = User.create(email:"pr@TheMarketingCalendar.com", first_name: "Preston", last_name: "Rohner", password: "foobar", password_confirmation: "foobar")
    user_ya = User.create(email:"ya@TheMarketingCalendar.com", first_name: "Yves", last_name: "Accad", password: "foobar", password_confirmation: "foobar")

    # user_pr.save
    # user_ya.save
    
    sales_support = CategoryGroup.create(description: "Sales Support", color_scheme: cs1)
    sales_promotion = Category.create(description: "Sales Promotions", color_scheme: cs2)
    collateral = Category.create(description: "Collateral & Presentations", color_scheme: cs3)

    sales_support.categories << sales_promotion
    sales_support.categories << collateral
    
    public_relations = CategoryGroup.create(description: "Public Relations", color_scheme: cs4)
    special_events = Category.create(description: "Special Events & Sponsorships", color_scheme: cs5)
    press_releases = Category.create(description: "Press Releases", color_scheme: cs6)
    public_relations.categories << special_events
    public_relations.categories << press_releases

    interactive = CategoryGroup.create(description: "Interactive", color_scheme: cs7)
    keyword = Category.create(description: "Keyword/Search", color_scheme: cs8)
    site_ads = Category.create(description: "Site Targeted Ads", color_scheme: cs9)
    auctions = Category.create(description: "Online Auctions/Stores", color_scheme: cs10)
    classifieds = Category.create(description: "Online Directory Listings & Classifieds", color_scheme: cs11)
    affiliates = Category.create(description: "Affiliate Programs", color_scheme: cs12)
    social_media = Category.create(description: "Social Media - Twitter, Facebook, etc.", color_scheme: cs13)
    blog = Category.create(description: "Blog/RSS", color_scheme: cs14)
    email = Category.create(description: "Email", color_scheme: cs15)
    website = Category.create(description: "Website Messaging", color_scheme: cs16)
    podcast = Category.create(description: "Podcast", color_scheme: cs17)
    mobile = Category.create(description: "Mobile", color_scheme: cs18)
    
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

    advertising = CategoryGroup.create(description: "Advertising", color_scheme: cs19)
    tv = Category.create(description: "TV", color_scheme: cs20)
    radio = Category.create(description: "Radio", color_scheme: cs1)
    print = Category.create(description: "Print", color_scheme: cs2)
    outdoor = Category.create(description: "Outdoor", color_scheme: cs3)
    advertising.categories << tv
    advertising.categories << radio
    advertising.categories << print
    advertising.categories << outdoor
    
    research = CategoryGroup.create(description: "Research", color_scheme: cs4)
    customer_surveys = Category.create(description: "Customer Surveys", color_scheme: cs5)
    advertising_effectiveness = Category.create(description: "Advertising Effectiveness", color_scheme: cs6)
    research.categories << customer_surveys
    research.categories << advertising_effectiveness

    e = Event.create(description:"Sales Promo (offer)", starts_at: make_time(2014, 1, 25), ends_at: make_time(2014, 2, 1))
    sales_promotion.events << e

    e = Event.create(description:"Product Brochures", starts_at: make_time(2014, 1, 10), ends_at: make_time(2014, 1, 17))
    collateral.events << e

    e = Event.create(description:"Industry Pres.", starts_at: make_time(2014, 1, 15), ends_at: make_time(2014, 1, 25))
    collateral.events << e

    e = Event.create(description:"Industry Conference", starts_at: make_time(2014, 1, 15), ends_at: make_time(2014, 1, 25))
    special_events.events << e

    e = Event.create(description:"Pre Conf", starts_at: make_time(2014, 1, 10), ends_at: make_time(2014, 1, 17))
    press_releases.events << e

    e = Event.create(description:"Post Conf", starts_at: make_time(2014, 1, 26), ends_at: make_time(2014, 1, 31))
    press_releases.events << e

    e = Event.create(description:"Keyword/Search Advertising", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    keyword.events << e

    e = Event.create(description:"Promote Conference", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 7))
    site_ads.events << e

    # e = Event.create(description:"Online Auction & Stores", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    # auctions.events << e
    # 
    # e = Event.create(description:"Online Directory Listings & Classified", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    # classifieds.events << e
    # 
    # e = Event.create(description:"Affiliate Recruitment Incentive Program", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    # affiliates.events << e
    # 
    # e = Event.create(description:"Facebook Announce", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 7))
    # social_media.events << e
    # 
    # e = Event.create(description:"Pre Conf Tweets", starts_at: make_time(2014, 1, 8), ends_at: make_time(2014, 1, 15))
    # social_media.events << e
    # 
    # e = Event.create(description:"Live Tweets", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 23))
    # social_media.events << e
    # 
    # e = Event.create(description:"Post Conf. Tweets", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    # social_media.events << e
    # 
    # e = Event.create(description:"Visit us at conference & receive free gift", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 14))
    # blog.events << e
    # 
    # e = Event.create(description:"Daily Conf. Recap", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 23))
    # blog.events << e
    # 
    # e = Event.create(description:"Upcoming Sales Promo", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    # social_media.events << e
    # 
    # e = Event.create(description:"Visit us at conference & receive free gift", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 14))
    # email.events << e
    # 
    # e = Event.create(description:"Upcoming Sales Promo", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    # email.events << e
    # 
    # e = Event.create(description:"Promo", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    # website.events << e
    # 
    # e = Event.create(description:"Coupon", starts_at: make_time(2014, 2, 1), ends_at: make_time(2014, 2, 7))
    # website.events << e
    # 
    # e = Event.create(description:"Highlights", starts_at: make_time(2014, 1, 24), ends_at: make_time(2014, 1, 31))
    # podcast.events << e
    # 
    # e = Event.create(description:"XYZ Campaign QR Code - product info", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 31))
    # mobile.events << e
    # 
    # e = Event.create(description:"XYZ Campaign", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 31))
    # tv.events << e
    # 
    # e = Event.create(description:"XYZ Campaign", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 31))
    # radio.events << e
    # 
    # e = Event.create(description:"XYZ Campaign with QR Code", starts_at: make_time(2014, 1, 16), ends_at: make_time(2014, 1, 31))
    # print.events << e
    # 
    # e = Event.create(description:"Survey", starts_at: make_time(2014, 1, 8), ends_at: make_time(2014, 1, 23))
    # customer_surveys.events << e
    # 
    # e = Event.create(description:"Campaign Analysis", starts_at: make_time(2014, 1, 1), ends_at: make_time(2014, 1, 31))
    # advertising_effectiveness.events << e
  end
end

def make_time(y, m, d)
  Time.utc(y, m, d)
end
