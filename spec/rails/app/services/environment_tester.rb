class EnvironmentTester
  def self.call
    ENV.fetch('API_KEY', '')
  end
end
