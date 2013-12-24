class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :campaign
  has_many :stakeholders
  has_many :users, :through => :stakeholders
end
