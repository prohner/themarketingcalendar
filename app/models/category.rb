class Category < ActiveRecord::Base
  belongs_to :category_group
  has_many :events
end
