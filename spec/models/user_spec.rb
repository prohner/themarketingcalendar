# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  first_name              :string(255)
#  last_name               :string(255)
#  email                   :string(255)
#  user_type               :integer
#  created_at              :datetime
#  updated_at              :datetime
#  password_digest         :string(255)
#  remember_token          :string(255)
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  email_summary_frequency :string(255)
#  stripe_customer_token   :string(255)
#

require 'spec_helper'

describe User do

  subject(:user) { User.new(first_name: "a", last_name: "b", email: "user@example.com", password: "123456", password_confirmation: "123456") }
  
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:full_name) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:user_type) }
  it { should respond_to(:user_type_description) }
  it { should respond_to(:all_events) }
  it { should respond_to(:all_events_in_timeframe) }
  it { should respond_to(:all_categories) }
  it { should respond_to(:wants_to_see_category_group) }
  it { should respond_to(:toggle_viewing_category_group) }
  it { should respond_to(:shares) }
  it { should respond_to(:partners) }
  it { should respond_to(:user_can_use_system) }
  it { should respond_to(:role?) }
  it { should respond_to(:email_summary_frequency) }
  it { should respond_to(:filename_for_user_to_download_data) }
  
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
  
  describe "user_type" do
    context "when user type is invalid" do
      it "should be invalid" do
        invalid_types = %w[0 5 -1]
        invalid_types.each do |bad_type|
          user.user_type = bad_type
          expect(user).not_to be_valid
        end
      end
    end

    context "when user type is valid" do
      it "should have a description for every value" do
        User::USER_TYPE_VALUES.each do |type|
          user.user_type = type
          expect(user.user_type_description).not_to be_nil
        end
      end
    end

    it "should have a description for every value" do
      User::USER_TYPE_VALUES.each do |type|
        expect(User.description_for_user_type(type)).not_to be_nil
      end
    end
    
    context "user_type defaults" do
      describe "User.administrator_user_type_value" do
        it "should respond with the right value" do
          user.user_type = User.administrator_user_type_value
          expect(user.role?(:administrator)).to be_truthy
        end
      end
    end
    
    it "default user type to administrator" do
      user = User.new(first_name: "a", last_name: "b", email: "user@example.com", password: "123456", password_confirmation: "123456")
      expect(user).to be_valid
      
      expect(user.role?(:administrator)).to be_truthy
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
  
  describe "#full_name" do
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
    
    it "should default to email if first and last are missing" do
      user.first_name = nil
      user.last_name = nil
      expect(user.full_name).to eq(user.email)
    end
  end
  
  describe "#default_value_for_empty_name" do
    it "should be the same as missing name" do
      user.first_name = User.default_value_for_empty_name
      expect(user.full_name).to eq(user.last_name)
    end

    it "should be okay with nil last name" do
      user.last_name = User.default_value_for_empty_name
      expect(user.full_name).to eq(user.first_name)
    end
    
    it "should default to email if first and last are missing" do
      user.first_name = User.default_value_for_empty_name
      user.last_name = User.default_value_for_empty_name
      expect(user.full_name).to eq(user.email)
    end
  end
  
  describe "remember token" do
    before { user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "owning events" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)
  
      @feb_01 = Date.strptime('02/01/2014', '%m/%d/%Y')
      @feb_28 = Date.strptime('02/28/2014', '%m/%d/%Y')
    end
    it "should return the correct number of events for all_events" do
      expect(@dave.all_events.count).to eq(10)
    end
    
    it "should return the correct number of events for Feb 2014 with all_events_in_timeframe " do
      events = @dave.all_events_in_timeframe(@feb_01.to_time.to_i, @feb_28.to_time.to_i)
      
      # puts "SPEC OUTPUT"
      # @dave.all_events.each do |e|
      #   puts "  #{e.explain}"
      # end
      # puts
      # events.each do |e|
      #   puts "  #{e.explain}"
      # end
      
      expect(events.count).to eq(12)
    end
    
    it "should do something reasonable if the arguments are unreasonable" do
      unreasonable_date = "this ain't no date"
      expect(@dave.all_events_in_timeframe(unreasonable_date, unreasonable_date)).to be_an(Array)
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
  
  describe "#wants_to_see_category_group" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)
      @category_group_to_see  = @dave.category_groups.first
      @category_group_to_hide = @dave.category_groups.last
    end
    
    it "should want to see a category group by default" do
      expect(@dave.wants_to_see_category_group(@category_group_to_hide)).to eq(true)
      expect(@dave.wants_to_see_category_group(@category_group_to_see)).to eq(true)
    end
  
    it "should answer correctly that category should be hidden" do
      hcf = HiddenCategoryGroupFlag.create(:user => @dave, :category_group => @category_group_to_hide)
      expect(@dave.wants_to_see_category_group(@category_group_to_hide)).to eq(false)
    end
    
    it "should answer correctly that category should be hidden" do
      hcf = HiddenCategoryGroupFlag.create(:user => @dave, :category_group => @category_group_to_hide)
      expect(@dave.wants_to_see_category_group(@category_group_to_see)).to eq(true)
    end
  end
  
  describe "toggle_viewing_category" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)
      @category_group  = @dave.category_groups.first
      @category_group2 = @dave.category_groups.last
    end
    
    it "should toggle a category" do
      @dave.toggle_viewing_category_group(@category_group)
      expect(@dave.wants_to_see_category_group(@category_group)).to eq(false)
  
      # destroy in the toggle_viewing_category doesn't seem to take effect in test environment
      # @dave.hidden_category_flags.reload
      # @dave.toggle_viewing_category(@category)
      # @dave.wants_to_see_category(@category).should == true
    end
  
    it "should work when toggling multiple category groups" do
      @dave.toggle_viewing_category_group(@category_group)
      @dave.toggle_viewing_category_group(@category_group2)
      expect(@dave.wants_to_see_category_group(@category_group)).to eq(false)
      expect(@dave.wants_to_see_category_group(@category_group2)).to eq(false)
    end
    
    it "should work when toggling category groups on AND off" do
      @dave.toggle_viewing_category_group(@category_group)

      expect(@dave.wants_to_see_category_group(@category_group)).to eq(false)
      expect(@dave.wants_to_see_category_group(@category_group2)).to eq(true)
    end
  end

  context "#email_summary_frequency" do
    it { should respond_to(:email_summary_frequency) }
    let(:dave) { FactoryGirl.create(:user_dave) }

    describe "valid values" do
      it "should allow only valid values" do
        [:none, :daily, :weekdays].each do |val|
          dave.email_summary_frequency = val
          expect(dave).to be_valid
        end
      end

      it "should not allow invalid values" do
        [:xnone, :xdaily, :xweekdays].each do |val|
          dave.email_summary_frequency = val
          expect(dave).not_to be_valid
        end
      end
    end
    
  end
  
  
  context "when sharing category groups" do
    let(:dave) { FactoryGirl.create(:user_dave) }
    let(:bill) { FactoryGirl.create(:user_bill) }
    let(:share) { Share.create(:owner => dave, :partner => bill, :category_group => dave.category_groups.first, :user_type => User.user_type_values[0]) }
    
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
        # Not sure why has_many association it needs to be accessed before using counts below.
        expect(dave.shares).to eq ([share])
        expect(bill.partners).to eq ([share])

        owned = bill.category_groups
        shared = bill.partners
        count_of_all_category_groups = owned.count + shared.count
        expect(bill.all_category_groups.count).to eq(count_of_all_category_groups)
      end
      
      
      it "should not return any duplicates" do
        share2 = Share.create(:owner => dave, :partner => bill, :category_group => dave.category_groups.first, :user_type => User.user_type_values[0])

        expect(share2).to be_valid
        expect(dave.shares).to match_array([share, share2])
        expect(bill.partners).to match_array([share, share2])

        owned_count = bill.category_groups.count
        shared_count = 1  ## two were shared, but only one unique
        count_of_all_category_groups = owned_count + shared_count
        expect(bill.all_category_groups.count).to eq(count_of_all_category_groups)
      end
      
      it "should not change ownership of any category groups" do
        # Not sure why has_many association it needs to be accessed before using counts below.
        expect(dave.shares).to eq ([share])
        expect(bill.partners).to eq ([share])

        expect(dave.category_groups.count).to eq (2)
        expect(bill.all_category_groups.count).to eq (3)
        expect(dave.category_groups.count).to eq (2)
        
      end
    end
  end
  
  describe "#all_events" do
    let(:dave) { FactoryGirl.create(:user_dave) }
    let(:bill) { FactoryGirl.create(:user_bill) }
    let(:share) { Share.create(:owner => dave, :partner => bill, :category_group => dave.category_groups.first) }

    it "should be able to get the shared events" do
      all_events = []
      bill.all_category_groups.each do |cg| 
        cg.categories.each do |category|
          category.events.each do |event|
            all_events << event
          end
        end
      end
      
      expect(bill.all_events).to match_array(all_events)
      
    end
  end
  
  
  describe "#user_can_use_system" do
    let(:user) { FactoryGirl.create(:user_dave) }

    skip "should actually verify the method"
    # it "should grant access appropriately" do
    #   User.status_options.each do |status|
    #     user.status = status
    #     if status == "signed up"
    #       expect(user.user_can_use_system).to be_truthy
    #     else
    #       expect(user.user_can_use_system).to be_falsey
    #     end
    #   end
    # end
  end
  
  describe "#role?" do
    let(:user) { FactoryGirl.create(:user_dave) }
    
    it "should raise a ArgumentError exception appropriately" do
      expect{user.role?(:abc)}.to raise_error(ArgumentError)
    end
    
    it "should respond correctly about each user type" do
      expect(user.role?(:root)).to be_truthy
    end
    
    it "should respond correctly about each user type: administrator" do
      user.user_type = 2
      expect(user.role?(:administrator)).to be_truthy
    end
    
    it "should respond correctly about each user type: user" do
      user.user_type = 3
      expect(user.role?(:user)).to be_truthy
    end
    
    it "should respond correctly about each user type: viewer" do
      user.user_type = 4
      expect(user.role?(:viewer)).to be_truthy
    end
  end

  describe ".default_value_for_password" do
    it "should have the method" do
      pwd = User.default_value_for_password
      expect(pwd).not_to eq("")
    end
  end
  
  context "default calendars and categories" do
    let(:user) { FactoryGirl.create(:user_dave) }
    let(:user_bill) { FactoryGirl.create(:user_bill) }
  
    before(:each) do
      x = user  ## Need to access variable to make sure it is all initialized
    end

    describe "#create_new_calendar_with_default_categories" do
      it "should respond to the method" do
        expect(user).to respond_to(:create_new_calendar_with_default_categories)
      end
    
      it "should add one calendar" do
        expect do
          user.create_new_calendar_with_default_categories
        end.to change { CategoryGroup.count }.by 1
      end
    
      it "should add the right number of categories" do
        expect do
          user.create_new_calendar_with_default_categories
        end.to change { Category.count }.by User.default_categories_hash.count
      end
    
      it "should only add the categories once for each user" do
        expect do
          user.create_new_calendar_with_default_categories
          user.create_new_calendar_with_default_categories
        end.to change { Category.count }.by User.default_categories_hash.count
      end
      
      it "should add categories the same number of categories for each user" do
        user.create_new_calendar_with_default_categories
        expect(user.default_calendar.categories.count).to eq(User.default_categories_hash.count)

        user_bill.create_new_calendar_with_default_categories
        expect(user_bill.default_calendar.categories.count).to eq(User.default_categories_hash.count)
      end
    end
  
    describe "#category_from_default_calendar" do
      it "should find the category" do
        user.create_new_calendar_with_default_categories
        User.default_categories_hash.keys.each do |key|
          category = user.category_from_default_calendar(key)
          expect(category).to be_a(Category)
          expect(category.description).to eq(User.default_categories_hash[key])
        end
      end
    end
  
    describe "#count_for_default_category" do 
      it "should return 0 for each fresh category" do
        user.create_new_calendar_with_default_categories
        User.default_categories_hash.keys.each do |key|
          expect(user.count_for_default_category(key)).to eq(0)
        end
      end

      it "should find events that exist category" do
        user.create_new_calendar_with_default_categories
        cat = user.category_from_default_calendar(:twitter)
        e = Event.create(description:"Twitter event", starts_at: Time.utc(2014, 2, 14), ends_at: Time.utc(2014, 2, 14), repetition_type: :none)
        cat.events << e
        
        expect(user.count_for_default_category(:twitter)).to eq(1)
      end
    end
  end
  
  describe "#root?" do
    it { should be_valid }

    it "should answer true if user is root level" do
      user.user_type = User.root_user_type_value
      expect(user.root?).to be_truthy
    end

    it "should answer false if user is not root level" do
      User.user_type_values.each do |val|
        unless val == User.root_user_type_value
          user.user_type = val
          expect(user.root?).to be_falsey
        end
      end
    end
  end

  describe "User.root_user_type_value" do
    it "should have all of the values for a root user" do
      user.user_type = User.root_user_type_value
      expect(User.user_types_array_for_user(user).count).to eq(User.user_type_values.count)
    end

    it "should have all of the values minus 1 for an administrator user" do
      user.user_type = 2
      expect(User.user_types_array_for_user(user).count).to eq(User.user_type_values.count - 1)
    end

    it "should have all of the values minus 2 for an user user" do
      user.user_type = 3
      expect(User.user_types_array_for_user(user).count).to eq(User.user_type_values.count - 2)
    end

    it "should have all of the values minus 3 for an administrator user" do
      user.user_type = 4
      expect(User.user_types_array_for_user(user).count).to eq(User.user_type_values.count - 3)
    end
  end
end
