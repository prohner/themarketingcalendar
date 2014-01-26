require 'spec_helper'

describe "categories/index" do
  before(:each) do
    @user = assign(:user, mock_model(User,
        :username => "Username",
        :first_name => "Bill First",
        :last_name => "Bill Last",
        :email => "Email Bill",
        :password => "Password"
      ))

    @category_group = assign(:category_group, stub_model(CategoryGroup, 
      :description => "category group", 
      :color_scheme => ColorScheme.new(:name => "color", :foreground => "black", :background => "white"),
      :user => @user
    ))
    
    
    @color_scheme = assign(:color_scheme, stub_model(ColorScheme,
      :name => "color scheme", 
      :foreground => "black", 
      :background => "white"
    ))
    
    assign(:categories, [
      stub_model(Category,
        :description => "Description",
        :category_group => @category_group,
        :color_scheme => @color_scheme
      ),
      stub_model(Category,
        :description => "Description",
        :category_group => @category_group,
        :color_scheme => @color_scheme
      )
    ])
    sign_in @user
  end

  it "renders a list of categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # assert_select "tr>td", :text => "Color".to_s, :count => 2
  end
  
  it "should have the category group name in the list"


  describe "categories list" do
    it "should login and display successfully"
    # it "User views categories page" do
    #   sign_in FactoryGirl.create(:user_dave)
    #   visit "/categories"
    #   expect(page).to have_title "#{application_name} | Categories"
    # end
  end

end
