require 'spec_helper'

describe "categories/index" do
  before(:each) do
    assign(:categories, [
      stub_model(Category,
        :description => "Description",
        :company_id => 1,
        :color => "Color"
      ),
      stub_model(Category,
        :description => "Description",
        :company_id => 1,
        :color => "Color"
      )
    ])
  end

  it "renders a list of categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
  end
end
