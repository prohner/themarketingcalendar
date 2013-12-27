class CategoryGroup < ActiveRecord::Base
  belongs_to :company
  has_many :categories
end
