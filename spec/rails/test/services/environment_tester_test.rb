require 'test_helper'

class EnvironmentTesterTest < Minitest::Test
  describe '.call' do
    subject { ::EnvironmentTester.call }
    it 'returns the environment variable value' do
      assert_equal 'api_key_value', subject
    end
  end
end
