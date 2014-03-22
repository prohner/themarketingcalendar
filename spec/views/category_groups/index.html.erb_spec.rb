require 'spec_helper'

describe "category_groups/index" do
  before(:each) do
    @bill = FactoryGirl.create(:user_bill)

    @dave = FactoryGirl.create(:user_dave)
    sign_in @dave

    @calendar1 = CategoryGroup.create(description: "desc", color_scheme: ColorScheme.new(name: "color", foreground: "x", background: "y"))
    @calendar2 = CategoryGroup.create(description: "desc", color_scheme: ColorScheme.new(name: "color", foreground: "x", background: "y"))

    @share = Share.new(:owner => @dave, :partner => @bill, :category_group => @calendar1)
    @dave.shares << @share
    
    assign(:category_groups, [@calendar1, @calendar2])
    assign(:share, [@share])
  end

  it "renders a list of category_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
  
  describe "category groups list" do
    # it "should login and display successfully"
    
    it "should have the right title" do
      visit "/category_groups"
      expect(page).to have_title "#{application_name} | Calendars"
    end
    
    it "User views category groups page" do
      render

      assert_select "tr>td", :text => "desc".to_s, :count => 2
      expect(rendered).to match @bill.full_name
    end
  end
  
end
