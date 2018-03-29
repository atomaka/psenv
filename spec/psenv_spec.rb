require "spec_helper"

RSpec.describe Psenv do
  let(:env_path) { "/env/" }
  let(:arg_paths) { ["/arg1/", "/arg2"] }
  let(:env_variables) { { TEST: "env", ANOTHER: "env" } }
  let(:arg_variables) do
    [{ ONE: "arg1", TWO: "arg1" }, { TWO: "arg2", THREE: "arg2" }]
  end
  let(:retriever1) { double(:retriever) }
  let(:retriever2) { double(:retriever) }
  let(:retriever3) { double(:retriever) }
  let(:environment) { double(:environment) }

  before(:each) do
    allow(Psenv::Retriever).to receive(:new).with(env_path) { retriever1 }
    allow(Psenv::Retriever).to receive(:new).with(arg_paths[0]) { retriever2 }
    allow(Psenv::Retriever).to receive(:new).with(arg_paths[1]) { retriever3 }
    allow(retriever1).to receive(:call) { env_variables }
    allow(retriever2).to receive(:call) { arg_variables[0] }
    allow(retriever3).to receive(:call) { arg_variables[1] }
    allow(Psenv::Environment).to receive(:create) { environment }
    allow(environment).to receive(:apply)
    allow(environment).to receive(:apply!)

    ENV.store("PARAMETER_STORE_PATH", nil)
  end

  it "has a version number" do
    expect(Psenv::VERSION).not_to be nil
  end

  context ".load" do
    context "when PARAMETER_STORE_PATH is set" do
      before(:each) do
        ENV.store("PARAMETER_STORE_PATH", env_path)
        Psenv.load
      end

      it "retrieves the correct path" do
        expect(Psenv::Retriever).to have_received(:new).with(env_path)
      end

      it "creates the environment with the correct variables" do
        expect(Psenv::Environment).
          to have_received(:create).with(env_variables)
      end

      it "applies the environment" do
        expect(environment).to have_received(:apply)
      end
    end

    context "when paths are passed in" do
      before(:each) { Psenv.load(*arg_paths) }

      it "retrieves the correct paths" do
        arg_paths.each do |path|
          expect(Psenv::Retriever).to have_received(:new).with(path)
        end
      end

      it "creates the environment with the correct variables" do
        expect(Psenv::Environment).
          to have_received(:create).with(*arg_variables)
      end

      it "apples the environment" do
        expect(environment).to have_received(:apply)
      end
    end
  end

  context ".overload" do
    context "when PARAMETER_STORE_PATH is set" do
      before(:each) do
        ENV.store("PARAMETER_STORE_PATH", env_path)
        Psenv.overload
      end

      it "retrieves the correct path" do
        expect(Psenv::Retriever).to have_received(:new).with(env_path)
      end

      it "creates the environment with the correct variables" do
        expect(Psenv::Environment).
          to have_received(:create).with(env_variables)
      end

      it "applies the environment" do
        expect(environment).to have_received(:apply!)
      end
    end

    context "when paths are passed in" do
      before(:each) { Psenv.overload(*arg_paths) }

      it "retrieves the correct paths" do
        arg_paths.each do |path|
          expect(Psenv::Retriever).to have_received(:new).with(path)
        end
      end

      it "creates the environment with the correct variables" do
        expect(Psenv::Environment).
          to have_received(:create).with(*arg_variables)
      end

      it "apples the environment" do
        expect(environment).to have_received(:apply!)
      end
    end
  end
end
