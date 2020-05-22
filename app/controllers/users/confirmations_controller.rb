class Users::ConfirmationsController < Devise::ConfirmationsController
  protected def after_confirmation_path_for(resource_name, resource)
    page_path :confirmed
  end
end
