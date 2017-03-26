class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    stored_location = stored_location_for(:user)
    stored_location = root_path if stored_location.blank? || stored_location == "/"
    stored_location
  end

  protected

  def store_current_location
    store_location_for(:user, request.url) if request.get?
  end

  def configure_permitted_parameters
    [:sign_up, :account_update].each do |action|
      devise_parameter_sanitizer.for(action) do |user_params|
        user_params.permit(
          :email,
          :password,
          :password_confirmation,
          :first_name,
          :last_name,
          :program,
          :graduation_year
        )
      end
    end
  end
end
