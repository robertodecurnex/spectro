class TestSC < Minitest::Test

  class TestCompiler < Minitest::Test
  
    def setup
      if File.exists?('test/files/.sc/undefined.yml')
        FileUtils.remove_file('test/files/.sc/undefined.yml') 
      end
      @compiler = SC::Compiler.new
    end
    
    def test_instance
      assert_equal @compiler, SC::Compiler.instance
    end

    def test_targets
      Dir.chdir('test/files') do 
        assert_equal ['sample.rb'], @compiler.send(:targets).sort
      end
    end

    def test_compile
      Dir.chdir('test/files') do 
        @compiler.compile
      end
      expected_yaml = <<YAML
---
"sample.rb":
- !ruby/object:SC::Spec
  md5: 94dd639208a00598a7248336398ad769
  rules:
  - !ruby/object:SC::Spec::Rule
    output: true
    params:
    - false
  signature: !ruby/object:SC::Spec::Signature
    name: unknown_lambda
    output_type: TrueClass
    params_types:
    - FalseClass
YAML
      assert File.exists?('test/files/.sc/undefined.yml'), 'SC::Compiler#compile was expected to create an undefined.yml file but it did not.'
      assert_equal YAML.load(expected_yaml), YAML.load_file('test/files/.sc/undefined.yml')
    end

  end

end
