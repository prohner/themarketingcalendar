require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Repetition Type/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Repetition Options/)
  end
end
