require 'spec_helper'

describe "category_groups/new" do
  before(:each) do
    assign(:category_group, stub_model(CategoryGroup).as_new_record)
  end

  it "renders new category_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", category_groups_path, "post" do
    end
  end
end
