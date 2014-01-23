namespace :notifications do
  desc "Sends notifications"
  task :send => :environment do
        UserMailer.daily_reminder.deliver
    end

end