class ColorScheme < ActiveRecord::Base
  has_many :category_groups
  has_many :categories
  has_many :campaigns
  
  def name
    "#{self.foreground} on #{self.background}"
  end
end
