module Psenv
  class Environment < Hash
    def apply
      each { |k, v| ENV.store(k, v) unless ENV.has_key?(k) }
    end

    def apply!
      each { |k, v| ENV.store(k, v) }
    end

    def self.create(*variables)
      Environment[variables.reverse.reduce({}, :merge)]
    end
  end
end
