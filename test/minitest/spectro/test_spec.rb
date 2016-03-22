require_relative 'spec/test_parser'
require_relative 'spec/test_rule'
require_relative 'spec/test_signature'

class TestSpectro < Minitest::Test

  class TestSpec < Minitest::Test

    def setup
		@rule = Spectro::Spec::Rule.new([1, 2], 3)
		@signature = Spectro::Spec::Signature.new('local_name', ['Fixnum'], 'Fixnum')
		@spec = Spectro::Spec.new('md5', @signature, [@rule])
    end

    def test_equal
		@spec2 = Spectro::Spec.new('md5', @signature, [@rule])
		assert @spec === @spec2
    end

  end

end
