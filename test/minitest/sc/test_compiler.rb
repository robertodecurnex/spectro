class TestSC < Minitest::Test

  class TestCompiler < Minitest::Test
  
    def setup
      if File.exists?('test/files/.sc/undefined.yml')
        FileUtils.remove_file('test/files/.sc/undefined.yml') 
      end
      @compiler = SC::Compiler.instance
    end
    
    def teardown
      if File.exists?('test/files/.sc/undefined.yml')
        FileUtils.remove_file('test/files/.sc/undefined.yml') 
      end
    end

    def test_targets
      Dir.chdir('test/files') do 
        assert_equal ['sample.rb', 'undefined_sample.rb'], @compiler.send(:targets).sort
      end
    end

    def test_compile
      Dir.chdir('test/files') do 
        @compiler.compile
      end
      expected_yaml = <<YAML
---
undefined_sample.rb:
- !ruby/object:SC::Spec
  md5: 23d8f3f75459cc94364520d99717a284
  rules:
  - !ruby/object:SC::Spec::Rule
    output: !ruby/class 'TrueClass'
    params: []
  signature: !ruby/object:SC::Spec::Signature
    name: i_am_undefined
    output_type: TrueClass
    params_types: []
sample.rb:
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
