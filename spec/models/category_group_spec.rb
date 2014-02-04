# == Schema Information
#
# Table name: category_groups
#
#  id              :integer          not null, primary key
#  description     :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  color_scheme_id :integer
#  user_id         :integer
#

require 'spec_helper'

describe CategoryGroup do
  before { @category_group = CategoryGroup.new(description:"desc") }
  
  subject { @category_group }
  
  it { should respond_to(:description) }
  it { should respond_to(:color_scheme) }
  it { should respond_to(:categories) }
  it { should respond_to(:shares) }
  it { should respond_to(:list_of_invited_partner_names) }

  describe "#list_of_invited_partner_names" do
    it "should return an array" do
      expect(@category_group.list_of_invited_partner_names).to be_an(Array)
    end
  end
end
