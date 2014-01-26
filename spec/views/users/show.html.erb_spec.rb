require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first_name => "Bill",
      :last_name => "Last Name",
      :email => "Email",
      :company_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Bill/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
  end
end
