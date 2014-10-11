require 'spec_helper'

describe "color_schemes/index" do
  before(:each) do
    assign(:color_schemes, [
      stub_model(ColorScheme,
        :name => "Name",
        :foreground => "Foreground",
        :background => "Background"
      ),
      stub_model(ColorScheme,
        :name => "Name",
        :foreground => "Foreground",
        :background => "Background"
      )
    ])
  end

  it "renders a list of color_schemes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Foreground".to_s, :count => 2
    assert_select "tr>td", :text => "Background".to_s, :count => 2
  end
end
