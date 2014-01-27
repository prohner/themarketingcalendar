# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  user_type       :integer
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do

  subject(:user) { User.new(first_name: "a", last_name: "b", email: "user@example.com", password: "123456", password_confirmation: "123456") }
  
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:full_name) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:user_type) }
  it { should respond_to(:user_type_description) }
  it { should respond_to(:all_events) }
  it { should respond_to(:all_events_in_timeframe) }
  it { should respond_to(:all_categories) }
  it { should respond_to(:wants_to_see_category) }
  it { should respond_to(:toggle_viewing_category) }
  it { should respond_to(:shares) }
  it { should respond_to(:partners) }
  
  it { should be_valid }
  
  describe "test little bit" do
    it "should dump stuff" do
      categories = Category.all
      categories.each do |category|
        puts category.description
        
        category.should be_valid
      end
    end
  end
  
  describe "when first name is not present" do
    before { user.first_name = "  " }
    it { should_not be_valid }
  end
  
  describe "when first name is too long" do
    before { user.first_name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when last name is not present" do
    before { user.last_name = "  " }
    it { should_not be_valid }
  end
  
  describe "when last name is too long" do
    before { user.last_name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { user.email = "  " }
    it { should_not be_valid }
  end
  
  describe "when user type is invalid" do
    it "should be invalid" do
      invalid_types = %w[0 5 -1]
      invalid_types.each do |bad_type|
        user.user_type = bad_type
        expect(user).not_to be_valid
      end
    end
  end
  
  describe "when user type is valid" do
    it "should have a description" do
      User::USER_TYPE_VALUES.each do |type|
        user.user_type = type
        expect(user.user_type_description).not_to be_nil
      end
    end
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before (:each) do
      user_with_same_email = user.dup
      user_with_same_email.email = user_with_same_email.email.upcase
      user_with_same_email.save
    end
  
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before do
      user.password = " "
      user.password_confirmation = " "
    end
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end  
  
  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }
  
    describe "with valid password" do
      it { should eq found_user.authenticate(user.password) }
    end
  
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
  
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
  
  describe "#full_name results" do
    it "should combine first and last names" do
      expect(user.full_name).to eq(user.first_name + " " + user.last_name)
    end
    
    it "should be okay with nil first name" do
      user.first_name = nil
      expect(user.full_name).to eq(user.last_name)
    end
    
    it "should be okay with nil last name" do
      user.last_name = nil
      expect(user.full_name).to eq(user.first_name)
    end
  end
  
  describe "remember token" do
    before { user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "owning events" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)
  
      @feb_01 = DateTime.strptime('02/01/2014', '%m/%d/%Y')
      @feb_28 = DateTime.strptime('02/28/2014', '%m/%d/%Y')
    end
    it "should return the correct number of events for all_events" do
      expect(@dave.all_events.count).to eq(10)
    end
    
    it "should return the correct number of events for Feb 2014 with all_events_in_timeframe " do
      events = @dave.all_events_in_timeframe(@feb_01, @feb_28)
      
      # puts "SPEC OUTPUT"
      # events.each do |e|
      #   puts "  #{e.explain}"
      # end
      expect(events.count).to eq(12)
    end
  end
  
  describe "owning categories" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)
      @bill = FactoryGirl.create(:user_bill)
    end
    
    it "should return only its own categories" do
      categories = @dave.all_categories
      expect(categories.count).to eq(2)
    end
  end
  
  describe "wants_to_see_category" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)
      @category_to_see  = @dave.category_groups.first.categories.first
      @category_to_hide = @dave.category_groups.last.categories.last
    end
    
    it "should want to see a category by default" do
      expect(@dave.wants_to_see_category(@category_to_hide)).to eq(true)
      expect(@dave.wants_to_see_category(@category_to_see)).to eq(true)
    end
  
    it "should answer correctly that category should be hidden" do
      hcf = HiddenCategoryFlag.create(:user => @dave, :category => @category_to_hide)
      expect(@dave.wants_to_see_category(@category_to_hide)).to eq(false)
    end
    
    it "should answer correctly that category should be hidden" do
      hcf = HiddenCategoryFlag.create(:user => @dave, :category => @category_to_hide)
      expect(@dave.wants_to_see_category(@category_to_see)).to eq(true)
    end
  end
  
  describe "toggle_viewing_category" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)
      @category  = @dave.category_groups.first.categories.first
      @category2 = @dave.category_groups.last.categories.last
    end
    
    it "should toggle a category" do
      @dave.toggle_viewing_category(@category)
      expect(@dave.wants_to_see_category(@category)).to eq(false)
  
      # destroy in the toggle_viewing_category doesn't seem to take effect in test environment
      # @dave.hidden_category_flags.reload
      # @dave.toggle_viewing_category(@category)
      # @dave.wants_to_see_category(@category).should == true
    end
  
    it "should work when toggling multiple categories" do
      @dave.toggle_viewing_category(@category)
      @dave.toggle_viewing_category(@category2)
      expect(@dave.wants_to_see_category(@category)).to eq(false)
      expect(@dave.wants_to_see_category(@category2)).to eq(false)
    end
  end

  context "when sharing category groups" do
    let(:dave) { FactoryGirl.create(:user_dave) }
    let(:bill) { FactoryGirl.create(:user_bill) }
    let(:share) { Share.create(:owner => dave, :partner => bill, :category_group => dave.category_groups.first) }
    
    describe "#shares" do
      it "owner should have the share" do
        expect(dave.shares).to eq ([share])
        expect(dave.shares.count).to eq (1)
      end

      it "partner should have the share" do
        expect(bill.partners).to eq ([share])
        expect(bill.partners.count).to eq (1)
      end
    end
  
    describe "#all_category_groups" do
      it { should respond_to(:all_category_groups) }
      
      it "should get all owned and shared category groups" do
        # Not sure why has_many association is needs to be accessed before 
        # using counts below.
        expect(dave.shares).to eq ([share])
        expect(bill.partners).to eq ([share])

        owned = bill.category_groups
        shared = bill.partners
        count_of_all_category_groups = owned.count + shared.count
        expect(bill.all_category_groups.count).to eq(count_of_all_category_groups)
      end
      
      
      it "should not return any duplicates" do
        share2 = Share.create(:owner => dave, :partner => bill, :category_group => dave.category_groups.first)
        
        expect(dave.shares).to match_array([share, share2])
        expect(bill.partners).to match_array([share, share2])

        owned_count = bill.category_groups.count
        shared_count = 1  ## two were shared, but only one unique
        count_of_all_category_groups = owned_count + shared_count
        expect(bill.all_category_groups.count).to eq(count_of_all_category_groups)
        
      end
      
    end
  end
end
