# == Schema Information
#
# Table name: hidden_category_group_flags
#
#  id                :integer          not null, primary key
#  category_group_id :integer
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class HiddenCategoryGroupFlag < ActiveRecord::Base
  belongs_to :user
  belongs_to :category_group
end
