Rails.application.config.assets.precompile += %w(application.scss screen.css print.css)
Rails.application.config.assets.precompile += %w(*.png *.jpg *.ico)
# Rails.configuration.assets.precompile += %w(rails_admin/*.scss rails_admin/*.css)
Rails.application.config.assets.precompile += %w(application.js rails_admin/*.js)