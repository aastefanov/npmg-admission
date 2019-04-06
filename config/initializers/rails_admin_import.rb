RailsAdmin.config do |config|
  # REQUIRED:
  # Include the import action
  # See https://github.com/sferik/rails_admin/wiki/Actions
  config.actions do
    all
    import
  end

  # Optional:
  # Configure global RailsAdminImport options
  config.configure_with(:import) do |config|
    config.logging = true
    config.line_item_limit = 6000 # Required for City imports
    config.rollback_on_error = false
  end
end