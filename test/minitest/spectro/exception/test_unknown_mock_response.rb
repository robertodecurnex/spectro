
class TestSpectro < Minitest::Test
  
  class TestException < Minitest::Test

    class TestUnknownMockResponse < Minitest::Test

      def test_exception
        exception = assert_raises Spectro::Exception::UnknownMockResponse do
          raise Spectro::Exception::UnknownMockResponse.new('path_here', 'method_name_here')
        end

        assert_equal '[#method_name_here] mock has not response defined for the given params. Verify the specs at "path_here".', exception.message
      end

    end

  end

end
