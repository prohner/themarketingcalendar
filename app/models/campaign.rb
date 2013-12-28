class Campaign < ActiveRecord::Base
  belongs_to :company
  has_many :events
  belongs_to :color_scheme
end
