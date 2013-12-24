require 'spec_helper'

describe "categories/new" do
  before(:each) do
    assign(:category, stub_model(Category,
      :description => "MyString",
      :company_id => 1,
      :color => "MyString"
    ).as_new_record)
  end

  it "renders new category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", categories_path, "post" do
      assert_select "input#category_description[name=?]", "category[description]"
      assert_select "input#category_company_id[name=?]", "category[company_id]"
      assert_select "input#category_color[name=?]", "category[color]"
    end
  end
end
