class TestSpectro < Minitest::Test

  class TestMock < Minitest::Test
    
    def teardown
      Spectro::Config.instance.mocks_enabled = nil
    end

    def test_create
      Dir.chdir('test/files') do 
        assert_equal nil, Spectro::Mock.create('sample.rb', 'unknown_lambda')
        assert_equal nil, Spectro::Mock.create('sample.rb', 'rule_of_three')
        Spectro::Config.instance.enable_mocks!
        assert_instance_of Proc, Spectro::Mock.create('sample.rb', 'unknown_lambda')
        assert_instance_of Proc, Spectro::Mock.create('sample.rb', 'rule_of_three')
      end
    end

    def test_mock_scope
      Dir.chdir('test/files') do 
        Spectro::Config.instance.enable_mocks!
        assert_equal true, Spectro::Mock.create('sample.rb', 'unknown_lambda').call(false)
        assert_equal 6.0, Spectro::Mock.create('sample.rb', 'rule_of_three').call(2.0, 4.0, 3.0)
      end
    end

    def test_mock_undefined_response
      Dir.chdir('test/files') do 
        Spectro::Config.instance.enable_mocks!
        assert_raises Spectro::Exception::UnknownMockResponse do 
          Spectro::Mock.create('sample.rb', 'unknown_lambda').call(true)
        end
      end
    end

  end

end
