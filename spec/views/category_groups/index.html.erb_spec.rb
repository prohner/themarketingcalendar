require 'spec_helper'

describe "category_groups/index" do
  before(:each) do
    assign(:category_groups, [
      CategoryGroup.create!(description: "desc", color_scheme: ColorScheme.new(name: "color", foreground: "x", background: "y")),
      CategoryGroup.create!(description: "desc", color_scheme: ColorScheme.new(name: "color", foreground: "x", background: "y"))
    ])
  end

  it "renders a list of category_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
