require 'spec_helper'

describe "color_schemes/edit" do
  before(:each) do
    @color_scheme = assign(:color_scheme, stub_model(ColorScheme))
  end

  it "renders the edit color_scheme form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", color_scheme_path(@color_scheme), "post" do
    end
  end
end
