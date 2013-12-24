require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :description => "Description",
        :campaign_id => 1,
        :category_id => 2,
        :repetition_type => "Repetition Type",
        :repetition_frequency => 3,
        :on_sunday => false,
        :on_monday => false,
        :on_tuesday => false,
        :on_wednesday => false,
        :on_thursday => false,
        :on_friday => false,
        :on_saturday => false,
        :repetition_options => "Repetition Options"
      ),
      stub_model(Event,
        :description => "Description",
        :campaign_id => 1,
        :category_id => 2,
        :repetition_type => "Repetition Type",
        :repetition_frequency => 3,
        :on_sunday => false,
        :on_monday => false,
        :on_tuesday => false,
        :on_wednesday => false,
        :on_thursday => false,
        :on_friday => false,
        :on_saturday => false,
        :repetition_options => "Repetition Options"
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Repetition Type".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 14
    # assert_select "tr>td", :text => false.to_s, :count => 2
    # assert_select "tr>td", :text => false.to_s, :count => 2
    # assert_select "tr>td", :text => false.to_s, :count => 2
    # assert_select "tr>td", :text => false.to_s, :count => 2
    # assert_select "tr>td", :text => false.to_s, :count => 2
    # assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Repetition Options".to_s, :count => 2
  end
end
