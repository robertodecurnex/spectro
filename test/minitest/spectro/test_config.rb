class TestSpectro < Minitest::Test
  
  class TestConfig < Minitest::Test
    
    def teardown
      Spectro::Config.instance.mocks_enabled = nil
    end

    def test_mocks_enabled?
      # Defaults to nil
      assert_equal false, Spectro::Config.mocks_enabled?
      # Force true with #enable_mocks
      assert_equal Spectro::Config.instance, Spectro::Config.enable_mocks!
      assert_equal true, Spectro::Config.mocks_enabled?
    end

  end
 
end
