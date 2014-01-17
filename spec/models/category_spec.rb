require 'spec_helper'

describe Category do
  before { @category = Category.new(description:"desc") }
  
  subject { @category }
  
  it { should respond_to(:description) }
  it { should respond_to(:color_scheme) }
  it { should respond_to(:category_group) }

  describe "object from scope" do
    it "should not be read only" do
      category = Category.create!(:description => "new cat", :category_group_id => 1)
      category.description = 'description new'
      category.save
      category.description.should == 'description new'
    end
  end
  
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
