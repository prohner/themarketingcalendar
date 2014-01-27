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

class Share < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", inverse_of: :shares
  belongs_to :partner, :class_name => "User", inverse_of: :partners
  belongs_to :category_group, :class_name => "CategoryGroup"
end
