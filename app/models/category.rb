class Category < ActiveRecord::Base
  belongs_to :category_group
  has_many :events
  belongs_to :color_scheme

  # default_scope order('description')
  
  # 2014-01-16 pcr I prefer order by group description, but it whacks tests because objects become read only
  # default_scope joins(:category_group).order('category_groups.description, description')
  
  validates :category_group_id, presence: true
  
end
