require 'spec_helper'

describe ShareController do
  before(:each) do
    @bill = FactoryGirl.create(:user_bill)
    @dave = FactoryGirl.create(:user_dave)

    @calendar1 = CategoryGroup.create(description: "desc", color_scheme: ColorScheme.new(name: "color", foreground: "x", background: "y"))
    @calendar2 = CategoryGroup.create(description: "desc", color_scheme: ColorScheme.new(name: "color", foreground: "x", background: "y"))

    @share = Share.new(:owner => @dave, :partner => @bill, :category_group => @calendar1)
    @dave.shares << @share
    
  end

  describe "GET 'edit'" do
    context "when NOT logged in" do
      it "redirects" do
        get 'edit', :id => @share.id
        expect(response).to redirect_to(signin_path)
      end
    end
    
    context "when logged in" do
      before(:each) do
        sign_in @dave
      end
      
      it "returns http success" do
        get 'edit', :id => @share.id
        expect(assigns(:share)).to eq(@share)
      end
    end
  end

  describe "GET 'destroy'" do
    context "when NOT logged in" do
      it "redirects" do
        get 'destroy', :id => @share.id
        expect(response).to redirect_to(signin_path)
      end
    end

    context "when logged in" do
      before(:each) do
        sign_in @dave
      end
      
      it "returns http success" do
        expect { 
          get 'destroy', :id => @share.id
        }.to change { Share.count }.by(-1)
      end
    end
  end

end
