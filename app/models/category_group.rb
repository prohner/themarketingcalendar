# == Schema Information
#
# Table name: category_groups
#
#  id              :integer          not null, primary key
#  description     :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  color_scheme_id :integer
#

class CategoryGroup < ActiveRecord::Base
  has_many :categories
  belongs_to :color_scheme
  
  default_scope { order('description') }
end
