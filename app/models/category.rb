# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  description       :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  category_group_id :integer
#  color_scheme_id   :integer
#

class Category < ActiveRecord::Base
  belongs_to :category_group
  has_many :events
  belongs_to :color_scheme
  has_many :hidden_category_flags

  default_scope { order('description') }
  # default_scope { joins(:category_group).order('category_groups.description, description') }
  
  validates :category_group_id, presence: true
  
end
