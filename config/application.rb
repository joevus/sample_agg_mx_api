require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleAgg
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    ::MXPlatformRuby.configure do |config|
      config.username = '36f874c0-a323-4e1f-8097-f814a1541af4'
      config.password = 'd90833afdf7c8d064c679c27f1a1f4141156a6c9'
      config.base_url = 'https://int-api.mx.com' # in production, use 'https://api.mx.com'
    end

    MXPlatformRuby.client.http_client.debug_dev=(Rails.logger)
  end
end
