module Psenv
  class Environment
    def initialize(*variables)
      @variables = variables.reverse.reduce({}, :merge)
    end

    def apply
      @variables.each do |k, v|
        ENV.store(k.to_s, v) unless ENV.key?(k.to_s)
      end
    end

    def apply!
      @variables.each { |k, v| ENV.store(k.to_s, v) }
    end
  end
end
