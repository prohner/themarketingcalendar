require 'spec_helper'

describe "color_schemes/index" do
  before(:each) do
    assign(:color_schemes, [
      stub_model(ColorScheme),
      stub_model(ColorScheme)
    ])
  end

  it "renders a list of color_schemes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
