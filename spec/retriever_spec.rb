require "spec_helper"

require "ostruct"

RSpec.describe Psenv::Parameter do
  context ".new" do
    let(:parameter) do
      {
        name: "/psenv/test/VARIABLE",
        value: "value",
        type: "String",
        version: 1,
      }
    end
    subject { Psenv::Parameter.new(parameter) }

    it "creates a paraemeter object" do
      expect(subject).to be_kind_of(Psenv::Parameter)
    end

    it "stores the correct name" do
      expect(subject.name).to eq("VARIABLE")
    end

    it "stores the value" do
      expect(subject.value).to eq("value")
    end
  end
end

RSpec.describe Psenv::Retriever do
  context ".new" do
    it "creates a retriever object" do
      expect(Psenv::Retriever.new("A")).to be_kind_of(Psenv::Retriever)
    end
  end

  context "#call" do
    let(:ssm) { double }
    before(:each) { allow(Aws::SSM::Client).to receive(:new) { ssm } }

    subject { Psenv::Retriever.new("/psenv/test").call }

    context "with a single page request" do
      before(:each) do
        allow(ssm).to receive(:get_parameters_by_path) {
          OpenStruct.new(
            parameters: [{
              name: "/psenv/test/API_KEY",
              value: "value",
              type: "String",
              version: 1,
            }],
          )
        }
      end

      it "returns the parsed parameters" do
        expect(subject).to eq("API_KEY" => "value")
      end
    end

    context "with multiple pages" do
      before(:each) do
        allow(ssm).to receive(:get_parameters_by_path) {
          OpenStruct.new(
            parameters: [{
              name: "/psenv/test/API_KEY",
              value: "value",
              type: "String",
              version: 1,
            }],
            next_page?: true,
            next_page: OpenStruct.new(
              parameters: [{
                name: "/psenv/test/CLIENT_KEY",
                value: "value",
                type: "String",
                version: 1,
              }],
            ),
          )
        }
      end

      it "returns both parameters" do
        expect(subject).to eq("API_KEY" => "value", "CLIENT_KEY" => "value")
      end
    end

    context "when the request fails" do
      before(:each) { allow(ssm).to receive(:get_parameters_by_path).and_raise }

      it "raises a RetrieveError" do
        expect { subject }.to raise_error(Psenv::RetrieveError)
      end
    end
  end
end
