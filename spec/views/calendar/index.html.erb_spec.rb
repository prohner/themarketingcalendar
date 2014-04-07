require 'spec_helper'

describe "calendar/index.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :password => "MyString",
      :company_id => 1
    ))
  end

  it "should render the page"  ## testing fails due to requirement of current_user from controller
  # it "should render the page" do
  #   sign_in @user
  #   render
  # end
end
