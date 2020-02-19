require "aws-sdk-ssm"

module Psenv
  class RetrieveError < StandardError; end

  class Parameter
    attr_reader :name, :value

    def initialize(parameter)
      @name = parameter[:name].split("/").last
      @value = parameter[:value]
      @type = parameter[:type]
      @version = parameter[:version]
    end
  end

  class Retriever
    def initialize(path)
      @path = path
    end

    def call
      Hash[
        parameters
          .map { |parameter| Parameter.new(parameter) }
          .map { |parameter| [parameter.name, parameter.value] }
      ]
    end

    def self.call(path)
      new(path).call
    end

    private

    def ssm
      @ssm ||= Aws::SSM::Client.new
    end

    def parameters
      parameters = []
      response = ssm.get_parameters_by_path(path: @path, with_decryption: true)
      parameters << response.parameters

      while response.next_page?
        response = response.next_page
        parameters << response.parameters
      end

      parameters.flatten
    rescue => error
      raise RetrieveError, error
    end
  end
end
