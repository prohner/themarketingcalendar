class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default :from => "admin@themarketingcalendar.com"

  def daily_reminder
    @interested_parties = InterestedParty.all
   
    mail(:to => ADMINISTRATOR_EMAIL_ADDRESSES,
         :subject => "Daily reminder of interested parties")    
  end
  
  def thank_you_interested_party(email, url)
    @email = email
    @url = url
    mail(:to => email, :subject => "Thank you for your interest!")
  end
  
  def shared_calendar_invitation(share)
    @owner = share.owner
    @partner = share.partner
    @calendar = share.category_group
    @invitation_url = "http://whatever/?u=#{share.uuid}"

    mail(:to => @partner.email, :subject => "#{@owner.full_name} shared '#{@calendar.description}' with you")
  end
end

