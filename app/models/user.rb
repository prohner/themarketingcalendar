# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  company_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#  user_type       :integer
#

class User < ActiveRecord::Base
  before_validation :default_values
  before_create :create_remember_token
  
  has_many :stakeholders
  has_many :events, :through => :stakeholders
  has_many :category_groups
  has_many :hidden_category_flags

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  USER_TYPES = [ [:root, 1], [:administrator, 2], [:user, 3], [:viewer, 4] ]
  USER_TYPE_VALUES = [1, 2, 3, 4]
  validates_inclusion_of :user_type, :in => USER_TYPE_VALUES
  
  has_secure_password
  validates :password, length: { minimum: 6 }

  def full_name
    f = ""
    l = ""
    f = first_name unless first_name.nil?
    l = last_name unless last_name.nil?

    (f.strip + " " + l.strip).strip
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def user_type_description
    case self.user_type
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
    category_groups.each do |cg|
      cg.categories.each do |c|
        events.concat(c.events)
      end
    end
    events
  end
  
  def all_categories
    categories = []
    category_groups.each do |cg|
      categories.concat(cg.categories)
    end
    categories.sort_by{|e| e.description}
  end
  
  def all_events_in_timeframe(start_date, end_date)
    # puts_user self
    # puts
    # puts "User#all_events_in_timeframe"
    events = []
    category_groups.each do |cg|
      cg.categories.each do |c|
        c.events.each do |e|
          # puts "  #{e.explain}"
          if e.repeating_event?
            evts = e.events_for_timeframe((start_date + 1).to_time.to_i, (end_date + 1).to_time.to_i)
            events.concat(evts)
          else
            if e.starts_at <= start_date and e.ends_at > start_date
              events << e
            elsif e.starts_at <= end_date and e.ends_at > end_date
              events << e
            end
          end
        end
      end
    end
    events
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def default_values
       self.email = email.downcase
       self.user_type ||= 1
    end
end
