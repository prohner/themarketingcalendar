# == Schema Information
#
# Table name: hidden_category_flags
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class HiddenCategoryFlag < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
end
