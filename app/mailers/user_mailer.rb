class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default :from => "admin@themarketingcalendar.com"

  def daily_reminder
    @interested_parties = InterestedParty.all
   
<<<<<<< HEAD
    mail(:to => ADMINISTRATOR_EMAIL_ADDRESSES,
         :subject => "Daily reminder of interested parties")    
=======
   puts "The admins are #{ActionMailer::Base.smtp_settings[:administrator_email_addresses]}"
    mail(:to => ActionMailer::Base.smtp_settings[:administrator_email_addresses],
        :subject => "Daily reminder of interested parties")    
>>>>>>> fa7224660dfae7ea4e36524076f2365178c88a4e
  end
  
  def thank_you_interested_party(email, url)
    @email = email
    @url = url
    mail(:to => email, :subject => "Thank you for your interest!")
  end
end

