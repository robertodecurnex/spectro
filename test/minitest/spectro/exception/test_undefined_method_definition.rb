class TestSpectro < Minitest::Test
  
  class TestException < Minitest::Test

    class TestUndefinedMethodDefinition < Minitest::Test

      def test_exception
        exception = assert_raises Spectro::Exception::UndefinedMethodDefinition do
          raise Spectro::Exception::UndefinedMethodDefinition.new('path_here', 'method_name_here')
        end

        assert_equal '[#method_name_here] has not been defiend for "path_here". Verify the specs at "path_here" and check the `spectro compile` output for more detailed information.', exception.message
      end

    end

  end

end
