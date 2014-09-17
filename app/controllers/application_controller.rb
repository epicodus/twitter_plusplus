class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    redirect_to user_root_path if user_signed_in?
  end

private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :handle
    devise_parameter_sanitizer.for(:account_update) << :bio
    devise_parameter_sanitizer.for(:account_update) << :avatar
  end

end
