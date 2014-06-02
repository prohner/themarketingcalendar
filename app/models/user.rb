# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  first_name              :string(255)
#  last_name               :string(255)
#  email                   :string(255)
#  user_type               :integer
#  created_at              :datetime
#  updated_at              :datetime
#  password_digest         :string(255)
#  remember_token          :string(255)
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  email_summary_frequency :string(255)
#  stripe_customer_token   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  before_validation :default_values
  before_create :create_remember_token
  after_create :create_a_customer
  
  has_many :stakeholders
  has_many :events, :through => :stakeholders
  has_many :category_groups
  has_many :hidden_category_group_flags
  has_many :notification_recipients
  
  has_many :shares, :foreign_key => 'owner_id', :class_name => "Share"
  has_many :partners, :foreign_key => 'partner_id', :class_name => "Share"

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  USER_TYPES = [ [:root, 1], [:administrator, 2], [:user, 3], [:viewer, 4] ]
  USER_TYPE_VALUES = [1, 2, 3, 4]
  validates_inclusion_of :user_type, :in => USER_TYPE_VALUES
  validates_inclusion_of :email_summary_frequency, :in => [:none, :daily, :weekdays]
  
  validates :password, length: { minimum: 6 }, :if => :should_validate_password?
  
  attr_accessor :stripe_card_token
  attr_accessor :updating_without_password
  
  def self.user_type_values
    USER_TYPE_VALUES
  end
  
  def self.root_user_type_value
    1
  end

  def self.administrator_user_type_value
    2
  end

  def self.user_types_array_for_user(current_user)
    ## Return only user types with same or lesser privilege
    USER_TYPES.select { |elem| elem[1] >= current_user.user_type }
  end
  
  def self.default_user_type_for_shares
    4
  end
  
  def should_validate_password?
    # Flipping the attribute
    if updating_without_password.nil?
      true
    else
      ! updating_without_password
    end
  end
  
  def create_a_customer
    unless Rails.env.test?
      # puts ""
      # puts ""
      # puts "#create_a_customer #{self.stripe_card_token}"
      # puts ""
      # puts ""
      token = self.stripe_card_token
    
      customer = Stripe::Customer.create(
        :card => token,
        :plan => "regular_monthly",
        :email => self.email
        )
        # puts "#create_a_customer #{customer.inspect}"
    end
  end
  
  def save_with_payment
    if valid?
      unless Rails.env.test?
        customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
        self.stripe_customer_token = customer.id
      end
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def email_summary_frequency
    if read_attribute(:email_summary_frequency).nil?
      :none
    else
      read_attribute(:email_summary_frequency).to_sym
    end
  end
  def email_summary_frequency=(value)
    write_attribute(:email_summary_frequency,value.to_s) 
  end
  
  
  def self.default_value_for_empty_name
    "tmc name tbd"
  end
  
  def self.default_value_for_password
    "secret"
  end
  
  def user_can_use_system
    true
  end
  
  def role?(role)
    if role == :root
      user_type == 1
    elsif role == :administrator
      user_type == 2
    elsif role == :user
      user_type == 3
    elsif role == :viewer
      user_type == 4
    else
      raise ArgumentError, 'Argument is invalid'
    end
  end

  def root?
    role?(:root)
  end
  
  def full_name
    f = ""
    l = ""
    f = first_name unless first_name.nil? || first_name == User.default_value_for_empty_name
    l = last_name unless last_name.nil? || last_name == User.default_value_for_empty_name

    if f == "" && l == ""
      email
    else
      (f.strip + " " + l.strip).strip
    end
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def user_type_description
    User.description_for_user_type(self.user_type)
  end
  
  def self.description_for_user_type(user_type)
    case user_type
    when 1
      "Root"
    when 2
      "Admin"
    when 3
      "User"
    when 4
      "Viewer"
    end
  end
  
  def all_events
    events = []
    all_category_groups.each do |cg|
      cg.categories.each do |c|
        events.concat(c.events)
      end
    end
    events
  end
  
  def all_categories
    # Should be handled like this:
    # has_many :posts
    # has_many :comments, through: :posts
    # has_many :commenters, through: :comments
    
    categories = []
    all_category_groups.each do |cg|
      categories.concat(cg.categories)
    end
    categories.sort_by{|e| e.description}
  end
  
  def all_category_groups
    all_of_them = []
    all_of_them.concat(category_groups)
    
    partners.each do |share|
      all_of_them << share.category_group
    end
    
    all_of_them.uniq!
    # all_of_them.sort { |a, b| a.description > b.description }
    all_of_them
  end
  
  def all_events_in_timeframe(start_date, end_date)
    debugging = false

    puts if debugging
    puts "User#all_events_in_timeframe" if debugging

    start_date ||= Date.today - 1.month - Date.today.day
    end_date ||= Date.today + 1.month - Date.today.day
    
    puts "#{start_date} to #{end_date} (#{start_date.class} and #{end_date.class})" if debugging
    start_date  = start_date.to_i
    end_date    = end_date.to_i
    # 
    # start_date = Date.strptime("2/1/2014", "%m/%d/%Y").to_time.to_i
    # end_date = Date.strptime("2/28/2014", "%m/%d/%Y").to_time.to_i
    
    
    puts "#{start_date} to #{end_date}" if debugging
    events = []
    
    all_category_groups.each do |cg|
      puts "#{cg.description}" if debugging
      cg.categories.each do |c|
        puts "  #{c.description}" if debugging
        c.events.each do |e|
          puts "    #{e.explain}" if debugging
          if e.repeating_event?
            evts = e.events_for_timeframe(start_date, end_date)
            puts "      evts.count: #{evts.count}" if debugging
            events.concat(evts)
          else
            puts "      a #{e.starts_at.to_time.to_i}, b #{start_date}" if debugging
            if e.starts_at.to_time.to_i <= start_date and e.ends_at.to_time.to_i > start_date
              puts "      b" if debugging
              events << e
            elsif e.starts_at.to_time.to_i <= end_date and e.ends_at.to_time.to_i > end_date
              puts "      c" if debugging
              events << e
            elsif start_date <= e.starts_at.to_time.to_i and e.starts_at.to_time.to_i <= end_date
              puts "      d" if debugging
              events << e
            end
          end
        end
      end
    end
    events
  end
  
  def toggle_viewing_category_group(category_group)
    if wants_to_see_category_group(category_group)
      # so we need to hide it
      hcgf = HiddenCategoryGroupFlag.create(:user => self, :category_group => category_group)
      hidden_category_group_flags << hcgf
      hcgf.save
    else
      # we need to remove the hidden flag
      self.hidden_category_group_flags.each do |hcf|
        if hcf.category_group_id == category_group.id
          hcf.destroy
        end
      end
    end
  end
  
  def self.default_calendar_name
    "My Calendar"
  end
  
  def self.default_categories_hash
    {
      :twitter => "Twitter",
      :facebook => "Facebook",
      :google_plus => "Google+",
      :instagram => "Instagram",
      :pinterest => "Pinterest",
      :google_search => "Google Search",
      :facebook_ads => "Facebook ads",
      :blogging => "Blogging",
      :podcasting => "Podcasting",
      :webinars => "Webinars",
      :email => "Email",
      :direct_mail => "Direct mail",
      :trade_shows => "Trade show"
    }
  end
  
  def create_new_calendar_with_default_categories
    cs = ColorScheme.all
    cal = default_calendar
    
    if cal.nil?
      cal = CategoryGroup.create(description: User.default_calendar_name, color_scheme: cs[0], user: self)
    end
    
    User.default_categories_hash.values.each.with_index(1) do |desc, i|
      if cs.count > 0
        scheme = cs[i % cs.count]
      else
        scheme = ColorScheme.create(name: "Graphite on cyan", background:"#06A2CB", foreground:"#192823")
      end
      
      # cat = Category.find_by_description(desc)
      cats = cal.categories.select { |cat| cat.description == desc }
      cat = cats[0]
      if cat.nil?
        cal.categories << Category.create(description: desc, color_scheme: scheme)
      end
    end
  end
  
  def count_for_default_category(category_symbol)
    category_from_default_calendar(category_symbol).events.count
  end
  
  def default_calendar
    category_groups.find_by_description(User.default_calendar_name)
  end
  
  def events_for_default_category(category_symbol)
    category_from_default_calendar(category_symbol).events
  end
  
  def category_from_default_calendar(category_symbol)
    cal = default_calendar
    category = Category.new
    description = User.default_categories_hash[category_symbol]
    unless cal.nil?
      cats = cal.categories.select { |c| c.description == description }
      category = cats[0] if cats.count > 0
    end
    category
  end
  
  def wants_to_see_category_group(category_group)
    wants_to_see = true
    self.hidden_category_group_flags.each do |hcf|
      if hcf.category_group_id == category_group.id
        wants_to_see = false
      end
    end
    wants_to_see
  end
  
  def csv_filename_for_user_to_download_data
    name = full_name.gsub(/[^0-9A-Za-z\-]/, '_')
    file = "#{Rails.root}/tmp/#{id}_#{name}.csv"
  end
  
  def filename_for_user_to_download_data
    file = csv_filename_for_user_to_download_data
    puts "Writing CSV to #{file}"
    CSV.open(file, 'w') do |writer|
      writer << ['Calendar', 'Category', 'Event', 'Starts', 'Ends', 'Notes', 'Frequency', 'Options', 'Repetition Type',
        'Sunday?', 'Monday?', 'Tuesday?', 'Wednesday?', 'Thursday?', 'Friday?', 'Saturday?'
      ]
      all_events.each do |e|
        writer << [e.category.category_group.description,
                    e.category.description,
                    e.description,
                    e.starts_at,
                    e.ends_at,
                    e.notes,
                    e.repetition_frequency,
                    e.repetition_options,
                    e.repetition_type,
                    e.on_sunday,
                    e.on_monday,
                    e.on_tuesday,
                    e.on_wednesday,
                    e.on_thursday,
                    e.on_friday,
                    e.on_saturday
                  ]
      end
    end    
    file
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def default_values
       self.email = email.downcase
       self.user_type ||= User.administrator_user_type_value
      self.email_summary_frequency ||= :none
    end
end
