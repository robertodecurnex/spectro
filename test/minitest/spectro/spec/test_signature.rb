class TestSpectro < Minitest::Test

  class TestSpec < Minitest::Test

    class TestSignature < Minitest::Test

      def setup
	  	@signature = Spectro::Spec::Signature.new('local_name', ['Fixnum'], 'Fixnum')
      end

      def test_equal
	  	@signature2 = Spectro::Spec::Signature.new('local_name', ['Fixnum'], 'Fixnum')
		assert @signature == @signature2
      end

    end

  end

end
