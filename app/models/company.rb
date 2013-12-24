class Company < ActiveRecord::Base
  has_many :users
  has_many :campaigns
  has_many :categories
end
