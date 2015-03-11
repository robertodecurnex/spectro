require_relative './spec/test_parser.rb'
require_relative './spec/test_rule.rb'
require_relative './spec/test_signature.rb'

class TestSC < Minitest::Test

  class TestSpec < Minitest::Test

    def setup
    end

    def test_equal
      skip "Assert that two different instances of SC::Spec are == if their instance variables are =="
    end

  end

end
