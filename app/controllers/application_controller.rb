class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
  end

  # Method that decrements the previous Location catches counters
  def decrement_catches_counters_location(location:, quantity:, weight:)
    location.decrement!(:catches_count, quantity)
    location.decrement!(:catches_weight, weight)
  end

  # Method that increments the current Location catches counters
  def increment_catches_counters_location(location:, quantity:, weight:)
    location.increment!(:catches_count, quantity)
    location.increment!(:catches_weight, weight)
  end
end
