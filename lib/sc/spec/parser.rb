module SC

  class Spec

    # Parser to get SC::Spec instances from the metadata on the program's files
    class Parser
      
      attr_accessor :file_path
 
      # @param [String] file_path the path of the file to parse
      def initialize file_path
        self.file_path = file_path
      end

      # Create an instance of SC::Spec::Parser for the given file path
      # and return the #parse response (the collection of SC::Spec instances 
      # for the given file)
      #
      # @param [String] file_path the path of the file to parse
      # @return [<SC::Spec>] collection of specs found in the given file path
      def self.parse(file_path)
        SC::Spec::Parser.new(file_path).parse
      end

      # Look for specs on the given file and parse them as SC::Specs
      #
      # @return [<SC::Spec>] collection of specs found in the given file path
      def parse
        /.*^__END__$(?<raw_specs>.*)\Z/m =~ File.read(self.file_path)
        return raw_specs.split('spec_for')[1..-1].map do |raw_spec|
          self.parse_spec raw_spec
        end
      end   
   
      # Parses a raw spec and returns an SC::Spec instance
      #
      # @param [String] raw_spec raw spec
      # @return [SC::Spec] the SC::Spec instance
      def parse_spec raw_spec
        spec_raw_signature, *spec_raw_rules = raw_spec.split("\n").reject(&:empty?)
        
        spec_signature = self.parse_spec_signature(spec_raw_signature)

        spec_rules = spec_raw_rules.map do |spec_raw_rule|
          self.parse_spec_rule(spec_raw_rule)
        end

        return SC::Spec.new(spec_signature, spec_rules)
      end

      # Returns a SC::Spec::Rule instance from the raw spec rule
      #
      # @param [String] spec_raw_rule raw rule if the spec
      # @return [SC::Spec::Rule]
      def parse_spec_rule spec_raw_rule
        # REGEX HERE PLEASE, F%#&!@* EASY
        raw_params, raw_output = spec_raw_rule.split('->').map(&:strip) 
        output = eval(raw_output)
        params = raw_params.split(/,\s+/).map do |raw_param|
          eval(raw_param)
        end

        return SC::Spec::Rule.new(params, output)
      end

      # Returns a SC::Spec::Signature from the raw spec signature
      #
      # @param [String] spec_raw_signature raw signature of the spec
      # @param [<SC::Spec::Signature]
      def parse_spec_signature spec_raw_signature
        # REGEX HERE PLEASE, F%#&!@* EASY
        raw_name_and_params_types, output_type = spec_raw_signature.split('->').map(&:strip)
        name, *params_types = raw_name_and_params_types.split(/,?\s+/).map(&:strip)

        return SC::Spec::Signature.new(name, params_types, output_type)
      end

    end

  end

end
