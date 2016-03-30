class TestSpectro < Minitest::Test

  class TestHTTPClient < Minitest::Test

    def setup
      Singleton.__init__(Spectro::Database)
      @http_client = Spectro::HTTPClient.instance
    end

    def test_upload_undefined_specs
      expected_body = <<-BODY
---
undefined_sample.rb:
- !ruby/object:Spectro::Spec
  md5: 23d8f3f75459cc94364520d99717a284
  rules:
  - !ruby/object:Spectro::Spec::Rule
    output: !ruby/class 'TrueClass'
    params: []
  signature: !ruby/object:Spectro::Spec::Signature
    name: i_am_undefined
    output_type: TrueClass
    params_types: []
sample.rb:
- !ruby/object:Spectro::Spec
  md5: 94dd639208a00598a7248336398ad769
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
      BODY

      Dir.chdir('test/files') do
        mock = Minitest::Mock.new
        mock.expect :request, true do |request|
          assert_equal Net::HTTP::Post, request.class
          assert_equal YAML.load(expected_body), YAML.load(request.body)
        end

        Spectro::Compiler.compile
        Net::HTTP.stub :new, mock do
          @http_client.upload_undefined_specs
          mock.verify
        end
      end
    end

  end

end
