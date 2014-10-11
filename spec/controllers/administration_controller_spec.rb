require 'spec_helper'

describe AdministrationController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to redirect_to(root_path)
    end
  end

end
