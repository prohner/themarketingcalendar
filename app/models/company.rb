class Company < ActiveRecord::Base
  has_many :users
  has_many :campaigns
  has_many :category_groups
end
