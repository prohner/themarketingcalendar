# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  description       :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  category_group_id :integer
#  color_scheme_id   :integer
#

require 'spec_helper'

describe Category do
  before { @category = Category.new(description:"desc") }
  
  subject { @category }
  
  it { should respond_to(:description) }
  it { should respond_to(:color_scheme) }
  it { should respond_to(:category_group) }
  
  describe "when category group is absent" do
    it "should be invalid" do
      expect(@category).not_to be_valid
    end    
  end
  
  describe "when category group is present" do
    it "should be valid" do
      color_scheme = ColorScheme.new({name: "color scheme", foreground: "x", background: "y"})
      @category.category_group_id = 1
      expect(@category).to be_valid
    end    
  end
  
end
