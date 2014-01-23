# == Schema Information
#
# Table name: color_schemes
#
#  id         :integer          not null, primary key
#  foreground :string(255)
#  background :string(255)
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

class ColorScheme < ActiveRecord::Base
  has_many :category_groups
  has_many :categories
  has_many :campaigns

  validates :name, presence: true
  validates :foreground, presence: true
  validates :background, presence: true
  
end
