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

class HelpRequest < ActiveRecord::Base
end
