require_relative 'spec/test_parser'
require_relative 'spec/test_rule'
require_relative 'spec/test_signature'

class TestSpectro < Minitest::Test

  class TestSpec < Minitest::Test

    def setup
    end

    def test_equal
      skip "Assert that two different instances of Spectro::Spec are == if their instance variables are =="
    end

  end

end
