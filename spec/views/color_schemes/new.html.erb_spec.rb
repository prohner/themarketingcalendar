require 'spec_helper'

describe "color_schemes/new" do
  before(:each) do
    assign(:color_scheme, stub_model(ColorScheme).as_new_record)
  end

  it "renders new color_scheme form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", color_schemes_path, "post" do
    end
  end
end
