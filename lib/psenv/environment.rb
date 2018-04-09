module Psenv
  class Environment < Hash
    def apply
      each { |k, v| ENV.store(k.to_s, v) unless ENV.has_key?(k.to_s) }
    end

    def apply!
      each { |k, v| ENV.store(k.to_s, v) }
    end

    def self.create(*variables)
      Environment[variables.reverse.reduce({}, :merge)]
    end
  end
end
