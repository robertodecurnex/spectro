class TestSpectro < Minitest::Test

  class TestSpec < Minitest::Test

    class TestRule < Minitest::Test

      def setup
	  	@rule = Spectro::Spec::Rule.new([1, 2], 3)
      end

      def test_equal
	  	@rule2 = Spectro::Spec::Rule.new([1, 2], 3)
		assert @rule == @rule2
      end

    end

  end

end
