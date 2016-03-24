class TestSpectro < Minitest::Test

  class TestClient < Minitest::Test

    def setup
      @client = Spectro::Client.new
    end

    def test_compile
      Dir.chdir('test/files') do
        mock = Minitest::Mock.new
        mock.expect :compile, true

        Spectro::Compiler.stub :instance, mock do
          @client.compile
          mock.verify
        end
      end
    end

    def test_compile
      Dir.mktmpdir do |tmp_dir|
        Dir.chdir(tmp_dir) do
          mock = Minitest::Mock.new
          mock.expect :init, true

          Spectro::Compiler.stub :instance, mock do
            @client.init
            mock.verify
          end
        end
      end
    end
  end
end
