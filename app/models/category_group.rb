class CategoryGroup < ActiveRecord::Base
  has_many :categories
  belongs_to :color_scheme
  
  default_scope order('description')
end
