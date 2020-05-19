# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
  end

  def after_sign_up_path_for(resource)
    :students
  end

  protected def after_inactive_sign_up_path_for(resource)
    :home_registered
  end

  def create
    super
    #if @user.persisted?
    #  UserMailer.with(:user => @user).welcome_email.deliver_now
    #end
  end
end
