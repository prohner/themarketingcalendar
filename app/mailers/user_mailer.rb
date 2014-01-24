class UserMailer < ActionMailer::Base
  default :from => "admin@themarketingcalendar.com"

  def daily_reminder
   @interested_parties = InterestedParty.all
   
   puts "The admins are #{UserMailer::ADMINISTRATOR_EMAIL_ADDRESSES}"
    mail(:to => UserMailer::ADMINISTRATOR_EMAIL_ADDRESSES,
        :subject => "Daily reminder of interested parties")    
  end
  
  
end
