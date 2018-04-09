require "spec_helper"

RSpec.describe Psenv::Environment do
  let(:environment1) { { A: "1", B: "1" } }
  let(:environment2) { { B: "2", C: "2" } }

  context ".create" do
    subject { Psenv::Environment.create(environment1, environment2) }

    it "returns an environment object" do
      expect(subject).to be_kind_of(Psenv::Environment)
    end

    it "is also a hash" do
      expect(subject).to be_kind_of(Hash)
    end

    it "creates the correct environment" do
      expected = { A: "1", B: "1", C: "2" }
      expect(subject).to eq(expected)
    end
  end

  context "#apply" do
    before(:each) do
      ENV.store("A", "0")
      environment = Psenv::Environment.create(environment1, environment2)
      environment.apply
    end

    it "does not overwrite existing environment" do
      expect(ENV["A"]).to eq("0")
    end

    it "applies unique variables as expected" do
      expect(ENV["C"]).to eq("2")
    end

    it "applies duplicates based on the first provided" do
      expect(ENV["B"]).to eq("1")
    end
  end

  context "#apply!" do
    before(:each) do
      ENV.store("A", "0")
      environment = Psenv::Environment.create(environment1, environment2)
      environment.apply!
    end

    it "does overwrite existing environment" do
      expect(ENV["A"]).to eq("1")
    end

    it "applies unique variables as expected" do
      expect(ENV["C"]).to eq("2")
    end

    it "applies duplicates based on the first provided" do
      expect(ENV["B"]).to eq("1")
    end 
  end
end
