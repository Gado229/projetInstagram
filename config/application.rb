require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Projetinsta
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.i18n.default_locale = :ja

    config.load_defaults 6.0

    config.generators do |g|
      # La description dans ces deux lignes crée un paramètre qui n'est pas généré automatiquement.
      g.assets false
      g.helper false
    end

  end
end
