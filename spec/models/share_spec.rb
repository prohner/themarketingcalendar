# == Schema Information
#
# Table name: shares
#
#  id                :integer          not null, primary key
#  owner_id          :integer
#  partner_id        :integer
#  category_group_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Share do
  let(:dave) { FactoryGirl.create(:user_dave) }
  let(:bill) { FactoryGirl.create(:user_bill) }
  let(:category_group) { dave.category_groups.first }

  subject(:share) { Share.new() }
  
  it { should respond_to(:owner) }
  it { should respond_to(:partner) }
  it { should respond_to(:category_group) }

  it "should be valid with good parameters" do
    share = Share.new(:owner => dave, :partner => bill, :category_group => category_group)
    expect(share).to be_valid
  end

  it "should require owner" do
    share = Share.new(:owner => nil, :partner => bill, :category_group => category_group)
    expect(share).not_to be_valid
  end

  it "should require partner" do
    share = Share.create(:owner => dave, :partner => nil, :category_group => category_group)
    expect(share).not_to be_valid
  end

  it "should require category group" do
    share = Share.create(:owner => dave, :partner => bill, :category_group => nil)
    expect(share).not_to be_valid
  end
  
  it "should have different owner and partner ids" do
    share = Share.create(:owner => dave, :partner => dave, :category_group => category_group)
    expect(share).not_to be_valid
  end
end
