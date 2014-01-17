require 'spec_helper'

describe "repeating_events/edit" do
  before(:each) do
    @repeating_event = assign(:repeating_event, stub_model(RepeatingEvent,
      :title => "MyString",
      :all_day => false,
      :description => "MyString",
      :repetition_type => "MyString",
      :repetition_frequency => 1,
      :on_sunday => false,
      :on_monday => false,
      :on_tuesday => false,
      :on_wednesday => false,
      :on_thursday => false,
      :on_friday => false,
      :on_saturday => false
    ))
  end

  it "renders the edit repeating_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", repeating_event_path(@repeating_event), "post" do
      assert_select "input#repeating_event_title[name=?]", "repeating_event[title]"
      assert_select "input#repeating_event_all_day[name=?]", "repeating_event[all_day]"
      assert_select "input#repeating_event_description[name=?]", "repeating_event[description]"
      assert_select "input#repeating_event_repetition_type[name=?]", "repeating_event[repetition_type]"
      assert_select "input#repeating_event_repetition_frequency[name=?]", "repeating_event[repetition_frequency]"
      assert_select "input#repeating_event_on_sunday[name=?]", "repeating_event[on_sunday]"
      assert_select "input#repeating_event_on_monday[name=?]", "repeating_event[on_monday]"
      assert_select "input#repeating_event_on_tuesday[name=?]", "repeating_event[on_tuesday]"
      assert_select "input#repeating_event_on_wednesday[name=?]", "repeating_event[on_wednesday]"
      assert_select "input#repeating_event_on_thursday[name=?]", "repeating_event[on_thursday]"
      assert_select "input#repeating_event_on_friday[name=?]", "repeating_event[on_friday]"
      assert_select "input#repeating_event_on_saturday[name=?]", "repeating_event[on_saturday]"
    end
  end
end
