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

require 'spec_helper'

describe Stakeholder do
  skip "add some examples to (or delete) #{__FILE__}"
end
