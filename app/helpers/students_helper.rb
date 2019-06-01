module StudentsHelper
  def check_closed_register?
    return Rails.configuration.configurable['registration_closed']
  end
end
