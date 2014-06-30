require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      subject { get 'home' }
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'help'" do
    it "returns http success" do
      subject { get 'help' }
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      subject { get 'about' }
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      subject { get 'contact' }
      expect(response.status).to eq(200)
    end
  end

  describe "POST 'contact'" do
    it "returns http success" do
      subject { post 'contact_help' }
      expect(response.status).to eq(200)
    end
  end

end
