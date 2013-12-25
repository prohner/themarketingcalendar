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
    rendered.should match(/Bill/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
  end
end
