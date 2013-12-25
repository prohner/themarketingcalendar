require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :username => "Username",
        :first_name => "Bill First",
        :last_name => "Bill Last",
        :email => "Email Bill",
        :password => "Password",
        :company_id => 1
      ),
      stub_model(User,
        :username => "Username",
        :first_name => "Tom First",
        :last_name => "Tom Last",
        :email => "Email Tom",
        :password => "Password",
        :company_id => 1
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # expect(rendered).to match /Bill First/
    # expect(rendered).to match /Tom First/

    # assert_select "tr>td", :text => "Bill".to_s, :count => 1
    # assert_select "tr>td", :text => "Tom".to_s, :count => 1
    assert_select "tr>td", :text => "Bill First".to_s, :count => 1
    assert_select "tr>td", :text => "Tom First".to_s, :count => 1

    assert_select "tr>td", :text => "Bill Last".to_s, :count => 1
    assert_select "tr>td", :text => "Tom Last".to_s, :count => 1
    assert_select "tr>td", :text => "Email Bill".to_s, :count => 1
    assert_select "tr>td", :text => "Email Tom".to_s, :count => 1
  end
end
