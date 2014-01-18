# == Schema Information
#
# Table name: interested_parties
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class InterestedParty < ActiveRecord::Base
end
