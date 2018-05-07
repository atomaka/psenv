require "bundler/gem_helper"
require "rspec/core/rake_task"
require "rubocop/rake_task"

namespace "psenv" do
  Bundler::GemHelper.install_tasks name: "psenv"
end

namespace "psenv-rails" do
  class ParameterStoreEnvRailsGemHelper < Bundler::GemHelper
    def guard_already_tagged; end

    def tag_version; end
  end

  ParameterStoreEnvRailsGemHelper.install_tasks name: "psenv-rails"
end

task build: ["psenv:build", "psenv-rails:build"]
task install: ["psenv:install", "psenv-rails:install"]
task release: ["psenv:release", "psenv-rails:release"]

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop spec]
