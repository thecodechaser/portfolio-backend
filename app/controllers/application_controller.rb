# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # without api calls
  # protect_from_forgery with: :exception

  # for api calls
  protect_from_forgery prepend: true

  # prevent users to perfrom action without authentication
  before_action :authenticate_user!, unless: :api_path

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :photo_link, :bio, :portfolio_link, :email, :password)
    end
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
end
