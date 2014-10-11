class AdministrationController < ApplicationController
  before_action :authorize_for_admin
  
  def index
  end
end
