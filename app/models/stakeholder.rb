# == Schema Information
#
# Table name: stakeholders
#
#  id                         :integer          not null, primary key
#  user_id                    :integer
#  event_id                   :integer
#  reminder_notification_days :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#

class Stakeholder < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
end
