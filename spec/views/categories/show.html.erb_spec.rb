require 'spec_helper'

describe "categories/show" do
  before(:each) do
    @category_group = assign(:category_group, stub_model(CategoryGroup, 
      :description => "category group", 
      :color_scheme => ColorScheme.new(:foreground => "black", :background => "white")
    ))
    @category = assign(:category, stub_model(Category,
      :description => "Description",
      :company_id => 1,
      :category_group => @category_group,
      :color_scheme => ColorScheme.new(:foreground => "black", :background => "white")
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    rendered.should match(/1/)
    rendered.should match(/Color/)
  end
end
