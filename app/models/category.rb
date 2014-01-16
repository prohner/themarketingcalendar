class Category < ActiveRecord::Base
  belongs_to :category_group
  has_many :events
  belongs_to :color_scheme
  
  validates :category_group_id, presence: true
  
end
