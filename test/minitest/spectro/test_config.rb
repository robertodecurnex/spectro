class TestSpectro < Minitest::Test

  class TestConfig < Minitest::Test

    def teardown
      Spectro::Config.instance.mocks_enabled = nil
      Spectro::Config.instance.api_hostname = nil
    end

    def test_mocks_enabled?
      # Defaults to nil
      assert_equal false, Spectro::Config.mocks_enabled?
      # Force true with #enable_mocks
      assert_equal Spectro::Config.instance, Spectro::Config.enable_mocks!
      assert_equal true, Spectro::Config.mocks_enabled?
    end

    def test_api_hostname
      # Defaults to localhsot:9292
      assert_equal 'localhost:9292', Spectro::Config.api_hostname
      # Overwrite the api hostname
      Spectro::Config.api_hostname = 'spectro_test_hostname'
      assert_equal 'spectro_test_hostname', Spectro::Config.api_hostname
      # Setting nil to return the default hostname
      Spectro::Config.api_hostname = nil
      assert_equal 'localhost:9292', Spectro::Config.api_hostname
    end

    def test_spectro_configure_instance
      Spectro.configure do |config|
        assert_equal Spectro::Config.instance, config
      end
    end

  end

end
