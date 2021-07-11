require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ScoldingApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.assets.initialize_on_precompile = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators.system_tests = nil

    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false, # ビューファイル用のスペックを作成しない。
        helper_specs: false, # ヘルパーファイル用のスペックを作成しない。
        routing_specs: false, # routes.rb用のスペックファイル作成しない。
        request_specs: false, # requestスペックを作成しない。
        model_specs: false # モデルスペックを作成しない。
      g.helper false
      g.assets false
      g.decorator false
    end
  end
end
