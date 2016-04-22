class TestSpectro < Minitest::Test

  class TestCompiler < Minitest::Test

    def setup
      Singleton.__init__(Spectro::Database)
      @compiler = Spectro::Compiler.instance
    end

    def teardown
      if File.exists?('test/files/.spectro/undefined.yml')
        FileUtils.remove_file('test/files/.spectro/undefined.yml')
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
      expected_yaml = <<-YAML
---
undefined_sample.rb:
- !ruby/object:Spectro::Spec
  description: ''
  md5: 23d8f3f75459cc94364520d99717a284
  rules:
  - !ruby/object:Spectro::Spec::Rule
    output: !ruby/class 'TrueClass'
    params: []
  signature: !ruby/object:Spectro::Spec::Signature
    name: i_am_undefined
    output_type: TrueClass
    params_types: []
  tags: []
sample.rb:
- !ruby/object:Spectro::Spec
  description: "Multi-line description \\nWith blank line in the middle"
  md5: d10062f3fefde7c4b1388be2cb7c7bb6
  rules:
  - !ruby/object:Spectro::Spec::Rule
    output: true
    params:
    - false
  signature: !ruby/object:Spectro::Spec::Signature
    name: unknown_lambda
    output_type: TrueClass
    params_types:
    - FalseClass
  tags: []
      YAML
      assert File.exists?('test/files/.spectro/undefined.yml'), 'Spectro::Compiler#compile was expected to create an undefined.yml file but it did not.'
      assert_equal YAML.load(expected_yaml), YAML.load_file('test/files/.spectro/undefined.yml')
    end

    def test_compile_without_init
        Dir.chdir('test/uninitialized_project') do
        assert_raises(SystemExit) do
            @compiler.compile
      end
        end
    end

    def test_init
      Dir.mktmpdir do |tmp_dir|
        Dir.chdir(tmp_dir) do
          @compiler.init
          assert Dir.exist? '.spectro'
          assert Dir.exist? '.spectro/cache'
          assert File.exist? '.spectro/config'
          assert File.exist? '.spectro/index.yml'
          assert File.exist? '.spectro/undefined.yml'
        end
      end
    end

    def test_init_on_initialized_project
        assert_raises(SystemExit) do
        Dir.chdir('test/files') do
          @compiler.init
        end
      end
    end

    def test_forced_init_on_project
      Dir.mktmpdir do |tmp_dir|
        Dir.chdir(tmp_dir) do
          @compiler.init
          File.open('.spectro/index.yml', 'w') do |file|
            file.write('content')
          end
          @compiler.init({f: true})
          assert(File.read('.spectro/index.yml') === '')
        end
      end
    end

  end

end
