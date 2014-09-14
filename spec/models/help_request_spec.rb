# == Schema Information
#
# Table name: help_requests
#
#  id          :integer          not null, primary key
#  email       :string(255)
#  subject     :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe HelpRequest do
  skip "add some examples to (or delete) #{__FILE__}"
end
