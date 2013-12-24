require 'spec_helper'

describe "events/new" do
  before(:each) do
    assign(:event, stub_model(Event,
      :description => "MyString",
      :campaign_id => 1,
      :category_id => 1,
      :repetition_type => "MyString",
      :repetition_frequency => 1,
      :on_sunday => false,
      :on_monday => false,
      :on_tuesday => false,
      :on_wednesday => false,
      :on_thursday => false,
      :on_friday => false,
      :on_saturday => false,
      :repetition_options => "MyString"
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", events_path, "post" do
      assert_select "input#event_description[name=?]", "event[description]"
      assert_select "input#event_campaign_id[name=?]", "event[campaign_id]"
      assert_select "input#event_category_id[name=?]", "event[category_id]"
      assert_select "input#event_repetition_type[name=?]", "event[repetition_type]"
      assert_select "input#event_repetition_frequency[name=?]", "event[repetition_frequency]"
      assert_select "input#event_on_sunday[name=?]", "event[on_sunday]"
      assert_select "input#event_on_monday[name=?]", "event[on_monday]"
      assert_select "input#event_on_tuesday[name=?]", "event[on_tuesday]"
      assert_select "input#event_on_wednesday[name=?]", "event[on_wednesday]"
      assert_select "input#event_on_thursday[name=?]", "event[on_thursday]"
      assert_select "input#event_on_friday[name=?]", "event[on_friday]"
      assert_select "input#event_on_saturday[name=?]", "event[on_saturday]"
      assert_select "input#event_repetition_options[name=?]", "event[repetition_options]"
    end
  end
end
