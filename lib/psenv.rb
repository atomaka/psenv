require "psenv/environment"
require "psenv/retriever"
require "psenv/version"

require "aws-sdk-ssm"

module Psenv
  module_function

  def load(*paths)
    paths.unshift(ENV["PARAMETER_STORE_PATH"]) if ENV["PARAMETER_STORE_PATH"]
    Environment.create(*paths.map { |path| retrieve_variables(path) }).apply
  end

  def overload(*paths)
    paths.unshift(ENV["PARAMETER_STORE_PATH"]) if ENV["PARAMETER_STORE_PATH"]
    Environment.create(*paths.map { |path| retrieve_variables(path) }).apply!
  end

  def retrieve_variables(path)
    Retriever.new(path).call
  end
end
