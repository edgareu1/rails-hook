class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { host: "https://www.hookeu.com" || "localhost:3000" }
  end

  protected

  def configure_permitted_parameters
    base_parameters = [:username, :email, :avatar, :password, :password_confirmation]

    devise_parameter_sanitizer.permit(:sign_up, keys: base_parameters)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: base_parameters.push(:current_password))
  end
end
