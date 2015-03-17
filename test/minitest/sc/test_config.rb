class TestSC < Minitest::Test
  
  class TestConfig < Minitest::Test
    
    def teardown
      SC::Config.instance.mocks_enabled = nil
    end

    def test_mocks_enabled?
      # Defaults to nil
      assert_equal false, SC::Config.mocks_enabled?
      # Force true with #enable_mocks
      assert_equal SC::Config.instance, SC::Config.enable_mocks!
      assert_equal true, SC::Config.mocks_enabled?
    end

  end
 
end
