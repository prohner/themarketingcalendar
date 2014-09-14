# == Schema Information
#
# Table name: notification_recipients
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe NotificationRecipient do
  skip "add some examples to (or delete) #{__FILE__}"
end
