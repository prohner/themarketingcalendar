require 'spec_helper'

describe "category_groups/edit" do
  before(:each) do
    @category_group = CategoryGroup.create!(description: "desc", color_scheme: ColorScheme.new(name: "color", foreground: "x", background: "y"))
  end

  it "renders the edit category_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", category_group_path(@category_group), "post" do
    end
  end
end
