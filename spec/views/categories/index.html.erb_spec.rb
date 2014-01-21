require 'spec_helper'

describe "categories/index" do
  before(:each) do
    @category_group = assign(:category_group, stub_model(CategoryGroup, 
      :description => "category group", 
      :color_scheme => ColorScheme.new(:foreground => "black", :background => "white")
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
  end

  it "renders a list of categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # assert_select "tr>td", :text => "Color".to_s, :count => 2
  end
  
  it "should have the category group name in the list"


  describe "categories list" do
    it "User views categories page" do
      visit "/categories"
      expect(page).to have_title "#{application_name} | Categories"
    end
  end

end
