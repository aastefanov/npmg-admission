require_relative 'boot'

require 'rails/all'

require 'egn'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nclc
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.i18n.available_locales = [:bg, :en]
    config.i18n.default_locale = :bg
    config.i18n.fallbacks = [:en]

    I18n.config.available_locales = [:bg, :en]
    I18n.default_locale = :bg
    # I18n.fallbacks = :en

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
