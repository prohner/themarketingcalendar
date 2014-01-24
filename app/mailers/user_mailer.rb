class UserMailer < ActionMailer::Base
  default :from => "admin@themarketingcalendar.com"

  def daily_reminder
   @interested_parties = InterestedParty.all
   
   puts "The admins are #{ActionMailer::Base.smtp_settings[:administrator_email_addresses]}"
    mail(:to => ActionMailer::Base.smtp_settings[:administrator_email_addresses],
        :subject => "Daily reminder of interested parties")    
  end
  
  
end

