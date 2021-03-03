class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_message
  rescue_from ActionController::RoutingError, with: :routing_error_message

  def record_not_message
    flash[:danger] = "アプリ内に該当する情報はありませんでした。"
    redirect_to action: "index" 
  end

  def routing_error_message
    render "index"
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[email nickname password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end

