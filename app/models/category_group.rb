class CategoryGroup < ActiveRecord::Base
  belongs_to :company
  has_many :categories
  belongs_to :color_scheme
end
