class TestSC < Minitest::Test

  class TestCompiler < Minitest::Test
  
    def setup
      if File.exists?('test/files/.sc/undefined.yml')
        FileUtils.remove_file('test/files/.sc/undefined.yml') 
      end
      @compiler = SC::Compiler.new('test/files/.sc')
    end
    
    def test_instance
      assert_equal @compiler, SC::Compiler.instance
    end

    def test_targets
      assert_equal ['./sample/sample.rb', './test/files/sample.rb'], @compiler.targets
    end

    def test_compile
      @compiler.compile
      expected_undefined = {
        'test/files/sample.rb' => {
          'unknown_lambda:1' => {
            'signature' => 'FalseClass -> TrueClass',
            'rules' => ['false -> true']
          }
        }
      }
      assert File.exists?('test/files/.sc/undefined.yml'), 'SC::Compiler#compile was expected to create an undefined.yml file but it did not.'
      assert_equal expected_undefined, YAML.load_file('test/files/.sc/undefined.yml')
    end

  end

end
