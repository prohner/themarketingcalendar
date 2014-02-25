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

require 'spec_helper'

describe NotificationRecipient do
  pending "add some examples to (or delete) #{__FILE__}"
end
