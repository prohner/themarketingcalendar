require 'spec_helper'

describe "category_groups/show" do
  before(:each) do
    @category_group = assign(:category_group, stub_model(CategoryGroup))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
