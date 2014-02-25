# == Schema Information
#
# Table name: notification_recipients
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class NotificationRecipient < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
end
