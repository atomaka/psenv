require "spec_helper"
require "rails"
require "psenv-rails"

RSpec.describe Psenv::Railtie do
  before(:each) do
    Rails.env = "test"
    Rails.application = double(:application)
  end

  context "before_configuration" do
    it "calls #load" do
      expect(Psenv::Railtie.instance).to receive(:load)
      ActiveSupport.run_load_hooks(:before_configuration)
    end
  end

  context ".load" do
    it "calls Psenv.load" do
      expect(Psenv).to receive(:load)
      Psenv::Railtie.load
    end
  end
end
