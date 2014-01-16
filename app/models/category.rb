class Category < ActiveRecord::Base
  belongs_to :category_group
  has_many :events
  belongs_to :color_scheme

  default_scope joins(:category_group).order('category_groups.description, description')
  
  validates :category_group_id, presence: true
  
end
