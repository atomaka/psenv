require "psenv"

if defined?(Rake.application)
  is_running_specs = Rake.application.top_level_tasks.grep(/^spec(:|$)/).any?
  Rails.env = ENV["RAILS_ENV"] ||= "test" if is_running_specs
end

module Psenv
  class Railtie < Rails::Railtie
    def load
      Psenv.load
    end

    def self.load
      instance.load
    end

    config.before_configuration { load }
  end
end
