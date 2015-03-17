class TestSpectro < Minitest::Test

  class TestSpec < Minitest::Test

    class TestParser < Minitest::Test

      def setup
        @parser = Spectro::Spec::Parser.new('./test/files/sample.rb')
      end

      def test_class_parser
        assert_equal @parser.parse, Spectro::Spec::Parser.parse('./test/files/sample.rb')
      end
    
      def test_parse
        @parser.parse.each do |spec|
          assert_instance_of Spectro::Spec, spec
        end
      end

      def test_parse_spec
        raw_spec = <<RAW_SPEC
spec_name String -> String
  "5tr1ng" -> "gn1rt5"
RAW_SPEC
        spec = @parser.parse_spec(raw_spec)
        assert_instance_of Spectro::Spec, spec
        assert_instance_of Spectro::Spec::Signature, spec.signature
        spec.rules.each do |rule|
          assert_instance_of Spectro::Spec::Rule, rule
        end
        assert_equal ['5tr1ng'], spec.rules.first.params
        assert_equal 'gn1rt5', spec.rules.first.output
        assert_equal 'spec_name', spec.signature.name
        assert_equal ['String'], spec.signature.params_types
        assert_equal 'String', spec.signature.output_type
      end

      def test_parse_spec_alternatives
        # Without params
        raw_spec = <<RAW_SPEC
spec_name -> String
  -> "gn1rt5"
RAW_SPEC
        spec = @parser.parse_spec(raw_spec)
        assert_equal [], spec.rules.first.params
        assert_equal 'gn1rt5', spec.rules.first.output
        assert_equal 'spec_name', spec.signature.name
        assert_equal [], spec.signature.params_types
        assert_equal 'String', spec.signature.output_type

        # With multiple params
        raw_spec = <<RAW_SPEC
spec_name String, String -> String
  "5tr", "1ng" -> "gn1rt5"
RAW_SPEC
        spec = @parser.parse_spec(raw_spec)
        assert_equal ['5tr', '1ng'], spec.rules.first.params
        assert_equal 'gn1rt5', spec.rules.first.output
        assert_equal 'spec_name', spec.signature.name
        assert_equal ['String', 'String'], spec.signature.params_types
        assert_equal 'String', spec.signature.output_type
      end

      def test_parse_spec_rule
        raw_spec_rule = <<RAW_SPEC_RULE
          "5tr1ng" -> "gn1rt5"
RAW_SPEC_RULE
        spec_rule = @parser.parse_spec_rule(raw_spec_rule)
        assert_instance_of Spectro::Spec::Rule, spec_rule
        assert_equal ['5tr1ng'], spec_rule.params
        assert_equal 'gn1rt5', spec_rule.output
      end
      
      def test_parse_spec_rule_alternatives
        raw_spec_rule = <<RAW_SPEC_RULE
          -> "gn1rt5"
RAW_SPEC_RULE
        spec_rule = @parser.parse_spec_rule(raw_spec_rule)
        assert_instance_of Spectro::Spec::Rule, spec_rule
        assert_equal [], spec_rule.params
        assert_equal 'gn1rt5', spec_rule.output

        raw_spec_rule = <<RAW_SPEC_RULE
          "5tr", "1ng" -> "gn1rt5"
RAW_SPEC_RULE
        spec_rule = @parser.parse_spec_rule(raw_spec_rule)
        assert_instance_of Spectro::Spec::Rule, spec_rule
        assert_equal ['5tr', '1ng'], spec_rule.params
        assert_equal 'gn1rt5', spec_rule.output
      end

      def test_parse_spec_signature
        raw_spec_signature = <<RAW_SPEC_SIGNATURE
          spec_name String -> String
RAW_SPEC_SIGNATURE
        spec_signature = @parser.parse_spec_signature(raw_spec_signature)
        assert_instance_of Spectro::Spec::Signature, spec_signature
        assert_equal 'spec_name', spec_signature.name
        assert_equal ['String'], spec_signature.params_types
        assert_equal 'String', spec_signature.output_type
      end
      
      def test_parse_spec_signature_alternatives
        raw_spec_signature = <<RAW_SPEC_SIGNATURE
          spec_name -> String
RAW_SPEC_SIGNATURE
        spec_signature = @parser.parse_spec_signature(raw_spec_signature)
        assert_instance_of Spectro::Spec::Signature, spec_signature
        assert_equal 'spec_name', spec_signature.name
        assert_equal [], spec_signature.params_types
        assert_equal 'String', spec_signature.output_type

        raw_spec_signature = <<RAW_SPEC_SIGNATURE
          spec_name String, String -> String
RAW_SPEC_SIGNATURE
        spec_signature = @parser.parse_spec_signature(raw_spec_signature)
        assert_instance_of Spectro::Spec::Signature, spec_signature
        assert_equal 'spec_name', spec_signature.name
        assert_equal ['String', 'String'], spec_signature.params_types
        assert_equal 'String', spec_signature.output_type
      end

    end

  end

end
