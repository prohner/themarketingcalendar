class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default :from => "The Marketing Calendar <admin@themarketingcalendar.com>"

  def daily_reminder
    @interested_parties = InterestedParty.all.select(:email).uniq
   
    mail(:to => ADMINISTRATOR_EMAIL_ADDRESSES,
         :subject => "Daily reminder of interested parties")    
  end
  
  def thank_you_interested_party(email, url)
    @email = email
    @url = url
    mail(:to => email, :subject => "Thank you for your interest!")
  end
  
  def shared_calendar_invitation(share, original_url)
    @owner = share.owner
    @partner = share.partner
    @calendar = share.category_group
    @invitation_url = "#{original_url}?u=#{share.uuid}"

    mail(:to => @partner.email, :subject => "#{@owner.full_name} shared '#{@calendar.description}' with you")
  end
  
  def daily_summary_to_user(user)
    user.email = "prestonrohner@me.com"
    if user.first_name == "Yves"
      user.email = "yaccad@gmail.com"
    end
    subject = "Daily Summary from The Marketing Calendar"
    
    @look_ahead_days = 5
    
    start_date_int = DateTime.now.to_i
    end_date_int = @look_ahead_days.days.from_now.to_i
    
    @user = user
    @events = user.all_events_in_timeframe(start_date_int, end_date_int)
    # @events.sort! { |a,b| a.starts_at <=> b.starts_at }
    @events.sort_by!{|event| [event.starts_at, event.description]}
    
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    puts "Emailing #{subject} to #{email_with_name}"
    if @events.count > 0
      mail(:to => email_with_name, :subject => subject)
    end
  end
  
  def daily_stakeholder_events_to_user(user)
    user.email = "prestonrohner@me.com"
    if user.first_name == "Yves"
      user.email = "yaccad@gmail.com"
    end
    subject = "Event Alerts from The Marketing Calendar"
    
    @user = user
    @events = []
    @user.stakeholders.each do |stakeholder|
        @events << stakeholder.event if stakeholder.event.number_of_days_until_event_starts == stakeholder.reminder_notification_days
    end

    if @events.count > 0 
      @events.sort_by!{|event| [event.starts_at, event.description]}
      email_with_name = "#{@user.full_name} <#{@user.email}>"
      puts "Emailing #{subject} to #{email_with_name}"
      mail(:to => email_with_name, :subject => subject)
    end
  end
  
  def daily_notification_recipients_email
    subject = "Event Alert from The Marketing Calendar"
    events = Event.all ##.before(2.days.from_now).after(Time.now)
    events.each do |event|
      event.notification_recipients.each do |recip|
        @recipient = recip
        recipient_email = @recipient.email
        
        recipient_email = 'preston@mscnet.com'
        
        mail(:to => recipient_email, :subject => subject)
      end
    end
  end
end

