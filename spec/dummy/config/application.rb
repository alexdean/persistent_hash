require File.expand_path('../boot', __FILE__)

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
  # action_mailer/railtie
  # active_job/railtie
  # action_cable/engine
  # action_mailbox/engine
  # action_text/engine
  # rails/test_unit/railtie

Bundler.require(*Rails.groups)
require "persistent_hash"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks. (added in 4.2)
    # config.active_record.raise_in_transactional_callbacks = true

    if Rails.version[0].to_i >= 7
      # https://guides.rubyonrails.org/active_record_multiple_databases.html#migrate-to-the-new-connection-handling
      config.active_record.legacy_connection_handling = false
    end
  end
end
