require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CleanupApp
  class Application < Rails::Application
    config.load_defaults 5.2
    config.autoload_paths += %W(#{config.root}/app/services)
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end
