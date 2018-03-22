require "psenv/version"

require "aws-sdk-ssm"

module Psenv
  module_function

  def load
    if ENV["PARAMETER_STORE_PATH"] != nil
      ssm = Aws::SSM::Client.new

      ssm.
        get_parameters_by_path(
          path: ENV["PARAMETER_STORE_PATH"],
          with_decryption: true,
        ).
        parameters.
        each do |param|
          ENV.store(param.name.split("/").last, param.value)
        end
    end
  end
end
