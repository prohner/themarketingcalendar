# == Schema Information
#
# Table name: shares
#
#  id                :integer          not null, primary key
#  owner_id          :integer
#  partner_id        :integer
#  category_group_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Share do
  subject(:share) { Share.new() }
  
  it { should respond_to(:owner) }
  it { should respond_to(:partner) }
  it { should respond_to(:category_group) }

  it "should have different owner and partner ids"
end
