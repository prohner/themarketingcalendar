require 'spec_helper'

describe "categories/edit" do
  before(:each) do
    @category = assign(:category, stub_model(Category,
      :description => "MyString",
      :company_id => 1,
      :color => "MyString"
    ))
  end

  it "renders the edit category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", category_path(@category), "post" do
      assert_select "input#category_description[name=?]", "category[description]"
      assert_select "input#category_company_id[name=?]", "category[company_id]"
      assert_select "input#category_color[name=?]", "category[color]"
    end
  end
end
