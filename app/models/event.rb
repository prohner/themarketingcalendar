# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  description          :string(255)
#  starts_at            :date
#  ends_at              :date
#  campaign_id          :integer
#  category_id          :integer
#  repetition_type      :string(255)
#  repetition_frequency :integer
#  on_sunday            :boolean
#  on_monday            :boolean
#  on_tuesday           :boolean
#  on_wednesday         :boolean
#  on_thursday          :boolean
#  on_friday            :boolean
#  on_saturday          :boolean
#  repetition_options   :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class Event < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  before_validation :default_values
  
  belongs_to :category
  has_many :stakeholders
  has_many :users, :through => :stakeholders

  def self.list_of_repetition_type_options
    ["none", "weekly", "monthly"]
  end
  
  validates :description, 
            :presence   => true,
            :length     => { :maximum => 150 }
  validates :category_id, :presence => true
  validates :starts_at, 
            :presence   => true
  validates :ends_at, 
            :presence   => true
  validates :repetition_type, 
            :presence   => true,
            :inclusion=> { :in => self.list_of_repetition_type_options }            

  attr_accessor :edit_url
  
  scope :before, lambda {|end_time| {:conditions => ["ends_at <= ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  scope :user_id, lambda {|studio_id| {:conditions => ["user_id = ?", user_id] }}

  validate :starts_at_must_be_before_ends_at
  
  def starts_at_must_be_before_ends_at
    unless starts_at.nil? or ends_at.nil?
      if starts_at > ends_at
        errors.add(:starts_at, "Start date must be before end date")
      end
    end
  end
  
  def repeating_event?
    self.repetition_type == "none" ? false : true
  end
  
  def repetition_type=(new_repetition_type)
    super new_repetition_type.nil? ? nil : new_repetition_type.to_s
  end
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      # These same variables are assigned individually, by name, in calendar.js.coffee
      :id => self.id,
      :title => "#{self.description} (#{self.category.description})",
      :description => "From event.rb description (fg:#{self.category.color_scheme.foreground}, bg:#{self.category.color_scheme.background})",
      :start => (self.starts_at + 1.days).rfc822,
      :end => (self.ends_at + 1.days).rfc822,
      :allDay => true,
      :recurring => false,
      :color => self.category.color_scheme.background.nil? ? "blue" : self.category.color_scheme.background,
      :textColor => self.category.color_scheme.foreground.nil? ? "white" : self.category.color_scheme.foreground,
      :location => "",
      :notes => "",
      :url => "", # used by FullCalendar
      #:my_url => self.edit_url #Rails.application.routes.url_helpers.edit_event_path(id)
      :my_url => edit_in_po_path(self),
      :category_id => self.category.id,
      :repetition_type => self.repetition_type
    }
  end
  
  def events_for_timeframe(from_date_as_int, to_date_as_int)
    events = []
    
    # puts "repetition type is #{self.repetition_type}"
    from_date = Time.at(from_date_as_int.to_i).to_formatted_s.to_date
    to_date   = Time.at(to_date_as_int.to_i).to_formatted_s.to_date
    if repetition_type == "weekly"
      # puts "working in weekly from #{from_date} to #{to_date} (starts=#{starts_at}, ends=#{ends_at})"
      (from_date..to_date).each do |d|
        # puts "  checking #{d} - #{appears_on_day(d)}"
        if appears_on_day_of_weekly_repetition(d)
          events << copy_of_self_for_one_day(d)
        end
      end
    elsif repetition_type == "monthly"
      (from_date..to_date).each do |d|
        if appears_on_day_of_monthly_repetition(d)
          events << copy_of_self_for_one_day(d)
        end
      end
    end
    #puts "adding #{@events.inspect}"
    events
  end
  
  def copy_of_self_for_one_day(the_day)
    str_starts_at = (the_day.strftime("%m/%d/%Y") + " " + starts_at.strftime("%H:%M"))
    str_ends_at = (the_day.strftime("%m/%d/%Y") + " " + ends_at.strftime("%H:%M"))
    
    #puts "starts==(#{str_starts_at})  ends==(#{str_ends_at})"
    new_starts_at = DateTime.strptime(str_starts_at, "%m/%d/%Y %H:%M")
    new_ends_at   = DateTime.strptime(str_ends_at, "%m/%d/%Y %H:%M")
    #puts "#{title} from #{new_starts_at} to #{new_ends_at} (#{starts_at}, #{ends_at})"
    
    # serialize then deserialize in order to copy the whole object
    new_event = Marshal::load(Marshal.dump(self))
    new_event.starts_at = new_starts_at
    new_event.ends_at = new_ends_at
    
    new_event
  end
  
  def explain
    "#{description}  #{starts_at}=>#{ends_at} (#{repetition_type})"
  end
  
  private
    def appears_on_day_of_monthly_repetition(day)
      is_it_on_the_day = false
      if day.day == starts_at.day
        # puts "checking #{day} between #{starts_at} and #{ends_at}"
        if (starts_at <= day and ends_at > day) or (starts_at < day and ends_at >= day)
          is_it_on_the_day = true
        end
      end
      is_it_on_the_day
    end

    def appears_on_day_of_weekly_repetition(day)
      is_it_on_the_day = false
      if (day.wday == 0 and on_sunday) or (day.wday == 1 and on_monday) or (day.wday == 2 and on_tuesday) or (day.wday == 3 and on_wednesday) or (day.wday == 4 and on_thursday) or (day.wday == 5 and on_friday) or (day.wday == 6 and on_saturday)
        # puts "checking #{day} between #{starts_at} and #{ends_at}"
        if (starts_at <= day and ends_at > day) or (starts_at < day and ends_at >= day)
          is_it_on_the_day = true
        end
      end
      is_it_on_the_day
    end

    def default_values
       self.repetition_type ||= :none
    end
  
end
