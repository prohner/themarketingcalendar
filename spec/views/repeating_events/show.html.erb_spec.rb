require 'spec_helper'

describe "repeating_events/show" do
  before(:each) do
    @repeating_event = assign(:repeating_event, stub_model(RepeatingEvent,
      :title => "Title",
      :all_day => false,
      :description => "Description",
      :repetition_type => "Repetition Type",
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

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/false/)
    rendered.should match(/Description/)
    rendered.should match(/Repetition Type/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
