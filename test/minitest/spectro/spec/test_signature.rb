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

      def test_to_hash
        assert_equal @signature.to_hash, {
          name: "local_name",
          output_type: "Fixnum",
          params_type: ["Fixnum"]
        }
      end

    end

  end

end
