# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  description          :string(255)
#  starts_at            :date
#  ends_at              :date
#  campaign_id          :integer
#  category_id          :integer
#  repetition_type      :string(255)
#  repetition_frequency :integer
#  on_sunday            :boolean
#  on_monday            :boolean
#  on_tuesday           :boolean
#  on_wednesday         :boolean
#  on_thursday          :boolean
#  on_friday            :boolean
#  on_saturday          :boolean
#  repetition_options   :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe Event do
  before { @event = Event.new(description: "a", starts_at: "b") }
  
  subject { @event }
  
  it { should be_valid }
end
