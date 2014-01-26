require 'spec_helper'

describe "categories/new" do
  before(:each) do
    @user = assign(:user, stub_model(User,
        :username => "Username",
        :first_name => "Bill First",
        :last_name => "Bill Last",
        :email => "Email Bill",
        :password => "Password"
      ))
    sign_in @user

    @category_group = assign(:category_group, stub_model(CategoryGroup, 
      :description => "category group", 
      :color_scheme => ColorScheme.new(:foreground => "black", :background => "white"),
      :user => @user
    ))

    assign(:category, stub_model(Category,
      :description => "MyString",
      :color_scheme => ColorScheme.new("foreground" => "black", "background" => "white"),
      :category_group => @category_group
    ).as_new_record)
  end

  it "renders new category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", categories_path, "post" do
      assert_select "input#category_description[name=?]", "category[description]"
      # assert_select "input#category_company_id[name=?]", "category[company_id]"
      # assert_select "input#category_color[name=?]", "category[color]"
    end
  end
end
