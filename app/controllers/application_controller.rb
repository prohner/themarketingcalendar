class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  ## redirect after Devise signin
  def after_sign_in_path_for(resource)
    calendar_index_path
  end

  protected

  def configure_permitted_parameters
    [:sign_up, :account_update].each do |action|
      devise_parameter_sanitizer.for(action) << :first_name
      devise_parameter_sanitizer.for(action) << :last_name
      devise_parameter_sanitizer.for(action) << :email_summary_frequency
      devise_parameter_sanitizer.for(action) << :stripe_card_token
    end
  end
  
end
