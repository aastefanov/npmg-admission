class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :set_locale

  def set_locale
    I18n.locale = :bg
  end

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "Нямате достъп до тази страница"
    flash[:error] = exception.message
    redirect_back fallback_location: root_path
  end
end
