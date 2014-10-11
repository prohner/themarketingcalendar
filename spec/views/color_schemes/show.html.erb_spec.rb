require 'spec_helper'

describe "color_schemes/show" do
  before(:each) do
    @color_scheme = assign(:color_scheme, stub_model(ColorScheme))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
