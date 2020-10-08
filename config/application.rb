require_relative 'boot'

# Require the relevant rails/libs one by one in order to ignore the mailbox lib
# It was creating too many unused routes
# require 'rails/all'

require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
require 'active_job/railtie'
require 'action_cable/engine'
# require 'action_mailbox/engine'
require 'action_text/engine'
require 'rails/test_unit/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hook
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
