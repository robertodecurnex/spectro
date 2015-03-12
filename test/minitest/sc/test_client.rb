class TestSC < Minitest::Test

  class TestClient < Minitest::Test

    def setup
      @client = SC::Client.new
    end

    def test_compile
      Dir.chdir('test/files') do 
        mock = Minitest::Mock.new
        mock.expect :compile, true
      
        SC::Compiler.stub :instance, mock do
          @client.compile
          mock.verify
        end
      end
    end

  end

end
