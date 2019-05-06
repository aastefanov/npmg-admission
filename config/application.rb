require File.expand_path('../boot', __FILE__)

#require 'rails/all'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
# require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end


# require 'pdfkit'

module Admission
  class Application < Rails::Application
    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.assets.initialize_on_precompile = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    # config.middleware.use PDFKit::Middleware, :print_media_type => true

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Sofia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.


    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.active_record.sqlite3.represent_boolean_as_integer = true

    config.i18n.fallbacks = true
    config.i18n.fallbacks = [:en, :bg]

    config.secret_key_base = '2b5a82983bffdbe2c891a0dcf06fd82eb1e5ae8180d9e64a3a14723951cce0a0d3d8b3b37f9f563637d7004b1940d000471acff51dbb37268ec4b92bc9c67ecc'
    config.action_mailer.default_url_options = {:host => 'nclc.npmg.org', :protocol => 'https'}
    config.action_mailer.smtp_settings = Admission::Application.config_for(:mailer).symbolize_keys
  end
end
