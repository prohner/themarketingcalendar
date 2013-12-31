class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :campaign
  has_many :stakeholders
  has_many :users, :through => :stakeholders

  attr_accessor :edit_url
  
  scope :before, lambda {|end_time| {:conditions => ["ends_at <= ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  scope :user_id, lambda {|studio_id| {:conditions => ["user_id = ?", user_id] }}

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => "#{self.description} (#{self.category.description})",
      :description => "From event.rb description (fg:#{self.category.color_scheme.foreground}, bg:#{self.category.color_scheme.background})",
      :start => self.starts_at.rfc822,
      :end => self.ends_at.rfc822,
      :allDay => true,
      :recurring => false,
      :color => self.category.color_scheme.background.nil? ? "blue" : self.category.color_scheme.background,
      :textColor => self.category.color_scheme.foreground.nil? ? "white" : self.category.color_scheme.foreground,
      :location => "",
      :notes => "",
      :url => "", # used by FullCalendar
      :my_url => self.edit_url #Rails.application.routes.url_helpers.edit_event_path(id)
    }
  end
end
