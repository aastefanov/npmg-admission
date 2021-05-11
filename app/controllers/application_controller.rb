class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_locale
  before_action :conf_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = :bg
    Time.zone = 'Europe/Sofia'
  end

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "Нямате достъп до тази страница"
    flash[:error] = exception.message
    redirect_back fallback_location: root_path
  end

  protected

  def conf_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
  end
end
