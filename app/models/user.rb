class User < ActiveRecord::Base
  belongs_to :company
  has_many :stakeholders
  has_many :events, :through => :stakeholders
end
