class TestSpectro < Minitest::Test

  class TestHTTPClient < Minitest::Test

    def setup
      @http_client = Spectro::HTTPClient.instance
    end

    def test_upload_undefined_specs
      Dir.chdir('test/files') do
        Spectro::Compiler.compile
        @http_client.upload_undefined_specs
      end
    end

  end

end
