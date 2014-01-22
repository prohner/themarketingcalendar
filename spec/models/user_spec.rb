# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  company_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#  user_type       :integer
#

require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "a", last_name: "b", email: "user@example.com", 
    password: "123456", password_confirmation: "123456") }
  
  subject { @user }
  
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
  
  it { should be_valid }
  
  describe "when first name is not present" do
    before { @user.first_name = "  " }
    it { should_not be_valid }
  end
  
  describe "when first name is too long" do
    before { @user.first_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @user.last_name = "  " }
    it { should_not be_valid }
  end
  
  describe "when last name is too long" do
    before { @user.last_name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "  " }
    it { should_not be_valid }
  end

  describe "when user type is invalid" do
    it "should be invalid" do
      invalid_types = %w[0 5 -1]
      invalid_types.each do |bad_type|
        @user.user_type = bad_type
        expect(@user).not_to be_valid
      end
    end
  end
  
  describe "when user type is valid" do
    it "should have a description" do
      User::USER_TYPE_VALUES.each do |type|
        @user.user_type = type
        @user.user_type_description.should_not be_nil
      end
    end
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before (:each) do
      user_with_same_email = @user.dup
      user_with_same_email.email = user_with_same_email.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(first_name: "a", last_name: "b", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end  
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
  
  describe "#full_name results" do
    it "should combine first and last names" do
      expect(@user.full_name).to eq(@user.first_name + " " + @user.last_name)
    end
    
    it "should be okay with nil first name" do
      @user.first_name = nil
      expect(@user.full_name).to eq(@user.last_name)
    end
    
    it "should be okay with nil last name" do
      @user.last_name = nil
      expect(@user.full_name).to eq(@user.first_name)
    end
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "owning events" do
    before(:each) do
      @dave = FactoryGirl.create(:user_dave)

      @feb_01 = DateTime.strptime('02/01/2014', '%m/%d/%Y')
      @feb_28 = DateTime.strptime('02/28/2014', '%m/%d/%Y')
    end
    it "should return the correct number of events for all_events" do
      @dave.all_events.count.should == 10
    end
    
    it "should return the correct number of events for Feb 2014 with all_events_in_timeframe " do
      events = @dave.all_events_in_timeframe(@feb_01, @feb_28)
      
      # puts "SPEC OUTPUT"
      # events.each do |e|
      #   puts "  #{e.explain}"
      # end
      events.count.should == 12
    end
    
    
  end
end
