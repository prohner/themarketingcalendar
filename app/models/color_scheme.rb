class ColorScheme < ActiveRecord::Base
  has_many :category_groups
  has_many :categories
  has_many :campaigns
end
