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

      def test_to_hash
        assert_equal @rule.to_hash, {
          output: 3,
          params: [1, 2]
        }
      end

    end

  end

end
