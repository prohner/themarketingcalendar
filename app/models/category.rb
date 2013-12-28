class Category < ActiveRecord::Base
  belongs_to :category_group
  has_many :events
  belongs_to :color_scheme
end
