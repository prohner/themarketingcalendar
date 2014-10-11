require 'spec_helper'

describe "color_schemes/show" do
  before(:each) do
    @color_scheme = assign(:color_scheme, stub_model(ColorScheme,
      :name => "Name",
      :foreground => "Foreground",
      :background => "Background"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Foreground/)
    expect(rendered).to match(/Background/)
  end
end
