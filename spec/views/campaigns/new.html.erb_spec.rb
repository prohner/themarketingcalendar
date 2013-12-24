require 'spec_helper'

describe "campaigns/new" do
  before(:each) do
    assign(:campaign, stub_model(Campaign,
      :description => "MyString",
      :company_id => 1,
      :color => "MyString"
    ).as_new_record)
  end

  it "renders new campaign form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", campaigns_path, "post" do
      assert_select "input#campaign_description[name=?]", "campaign[description]"
      assert_select "input#campaign_company_id[name=?]", "campaign[company_id]"
      assert_select "input#campaign_color[name=?]", "campaign[color]"
    end
  end
end
