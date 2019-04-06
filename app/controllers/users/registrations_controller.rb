# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name,:last_name, :password, :password_confirmation, :phone)
  end
end
