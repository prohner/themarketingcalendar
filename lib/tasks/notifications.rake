namespace :notifications do
  desc "Sends daily notifications to admins and users"
  task :send => :environment do
    UserMailer.daily_reminder.deliver
    
    ## this should be users who have requested a daily email summary
    User.all.each do |user|
      should_send_email = false
      
      if user.email_summary_frequency == :daily
        should_send_email = true
      elsif user.email_summary_frequency == :weekdays
        unless Date.today.saturday? or Date.today.sunday?
          should_send_email = true
        end
      end
      
      if should_send_email
        UserMailer.daily_summary_to_user(user).deliver
      end
    end
    # UserMailer.daily_summary_to_user(User.all.first).deliver
    
    ## this should be users who have requested a reminder that is due now
    User.all.each do |user|
      UserMailer.daily_stakeholder_events_to_user(user).deliver
    end
    # UserMailer.daily_stakeholder_events_to_user(User.all.first).deliver
    
  end

end