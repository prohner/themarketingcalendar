class CalendarMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default :from => "The Marketing Calendar <admin@themarketingcalendar.com>"

  def event_added_by_someone_else(event)
    @event = event
    mail(:to => "prestonrohner@me.com",
         :subject => "An event was added to your #{event.category.category_group.description} calendar")
  end
end