class RepeatingEvent < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  belongs_to :category
  has_many :stakeholders
  has_many :users, :through => :stakeholders

  attr_accessor :edit_url

  # CAUTION:  This is the reverse of Event
  scope :before, lambda {|end_time|   {:conditions => ["starts_at < ?", Event.format_date(end_time)] }}
  scope :after,  lambda {|start_time| {:conditions => ["ends_at > ?", Event.format_date(start_time)] }}

  validates :title, 
            :presence   => true,
            :length     => { :maximum => 50 }
  #validates :category_id, :presence => true
  
  validates_inclusion_of :repetition_type, :in => %w( daily weekdays weekly monthly )
  
  validate :must_have_valid_repetition_info
  validate :starts_at_must_be_before_ends_at

  def events_for_timeframe(from_date_as_int, to_date_as_int)
    events = []
    
    from_date = Time.at(from_date_as_int.to_i).to_formatted_s.to_date
    to_date   = Time.at(to_date_as_int.to_i).to_formatted_s.to_date
    if repetition_type == "weekly"
      #puts "working in weekly from #{from_date} to #{to_date}"
      (from_date..to_date).each do |d|
        if appears_on_day(d)
          str_starts_at = (d.strftime("%m/%d/%Y") + " " + starts_at.strftime("%H:%M"))
          str_ends_at = (d.strftime("%m/%d/%Y") + " " + ends_at.strftime("%H:%M"))
          
          #puts "starts==(#{str_starts_at})  ends==(#{str_ends_at})"
          new_starts_at = DateTime.strptime(str_starts_at, "%m/%d/%Y %H:%M")
          new_ends_at   = DateTime.strptime(str_ends_at, "%m/%d/%Y %H:%M")
          #puts "#{title} from #{new_starts_at} to #{new_ends_at} (#{starts_at}, #{ends_at})"
          events << Event.new(  :id => self.id + 1000000,
                                :title => self.title,
                                :starts_at => new_starts_at,
                                :ends_at => new_ends_at,
                                :studio_id => self.studio_id,
                                :color => self.color)
        end
      end
      
    end
    #puts "adding #{@events.inspect}"
    events
  end

  def appears_on_day(day)
    is_it_on_the_day = false
    if (day.wday == 0 and on_sunday) or (day.wday == 1 and on_monday) or (day.wday == 2 and on_tuesday) or (day.wday == 3 and on_wednesday) or (day.wday == 4 and on_thursday) or (day.wday == 5 and on_friday) or (day.wday == 6 and on_saturday)
      if starts_at < day and ends_at > day
        is_it_on_the_day = true
      end
    end
    is_it_on_the_day
  end

  def starts_at_must_be_before_ends_at
    unless starts_at.nil? or ends_at.nil?
      if starts_at.utc > ends_at.utc
        errors.add(:starts_at, "Start date must be before end date")
      end
    end
  end

  def must_have_valid_repetition_info
    case repetition_type
    when "weekly"
      if !on_sunday and !on_monday and !on_tuesday and !on_wednesday and !on_thursday and !on_friday and !on_saturday 
        errors.add(:repetition_type, "Need a day along with weekly")
      end
    when "monthly"
      if !on_sunday and !on_monday and !on_tuesday and !on_wednesday and !on_thursday and !on_friday and !on_saturday 
        errors.add(:repetition_type, "Need a day along with monthly")
      end
    end
  end
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => self.starts_at.rfc822,
      :end => self.ends_at.rfc822,
      :allDay => self.all_day,
      :recurring => true,
      :repetition_type => self.repetition_type,
      :color => self.color.nil? ? "green" : self.color,
      :location => self.location,
      :notes => self.notes,
      :on_sunday     => self.on_sunday    ,
      :on_monday     => self.on_monday    ,
      :on_tuesday    => self.on_tuesday   ,
      :on_wednesday  => self.on_wednesday ,
      :on_thursday   => self.on_thursday  ,
      :on_friday     => self.on_friday    ,
      :on_saturday   => self.on_saturday  ,
      :url => self.edit_url ##Rails.application.routes.url_helpers.event_path(id)
    }
  end

end
