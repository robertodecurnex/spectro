require 'spectro'

module Spectro

  class Spec

    # Parser to get Spectro::Spec instances from the metadata on the program's files
    class Parser

      attr_accessor :file_path

      # @param [String] file_path the path of the file to parse
      def initialize file_path
        self.file_path = file_path
      end

      # Create an instance of Spectro::Spec::Parser for the given file path
      # and returns the #parse response (the collection of Spectro::Spec instances
      # for the given file)
      #
      # @param [String] file_path the path of the file to parse
      # @return [<Spectro::Spec>] collection of specs found in the given file path
      def self.parse(file_path)
        Spectro::Spec::Parser.new(file_path).parse
      end

      # Looks for specs on the given file and parses them as Spectro::Specs
      #
      # @return [<Spectro::Spec>] collection of specs found in the given file path
      def parse
        /.*^__END__$(?<raw_specs>.*)\Z/m =~ File.read(self.file_path)
        return raw_specs.split('spec_for')[1..-1].map do |raw_spec|
          self.parse_spec raw_spec
        end
      end

      # Parses a raw spec and returns an Spectro::Spec instance
      #
      # @param [String] raw_spec raw spec
      # @return [Spectro::Spec] the Spectro::Spec instance
      def parse_spec raw_spec
        spec_raw_signature, *spec_raw_rules = raw_spec.split("\n").reject(&:empty?)

        spec_signature = self.parse_spec_signature(spec_raw_signature)

        spec_rules = spec_raw_rules.map do |spec_raw_rule|
          self.parse_spec_rule(spec_raw_rule)
        end

        spec_md5 = Digest::MD5.hexdigest(raw_spec)

        return Spectro::Spec.new(spec_md5, spec_signature, spec_rules)
      end

      # Returns an Spectro::Spec::Rule instance from the raw spec rule
      #
      # @param [String] spec_raw_rule raw rule if the spec
      # @return [Spectro::Spec::Rule] spec rule instance
      def parse_spec_rule spec_raw_rule
        # REGEX HERE PLEASE, F%#&!@* EASY
        raw_params, raw_output = spec_raw_rule.split('->').map(&:strip)
        output = eval(raw_output)
        params = raw_params.split(/,\s+/).map do |raw_param|
          eval(raw_param)
        end

        return Spectro::Spec::Rule.new(params, output)
      end

      # Returns a Spectro::Spec::Signature from the raw spec signature
      #
      # @param [String] spec_raw_signature raw signature of the spec
      # @param [<Spectro::Spec::Signature] spec signature instance
      def parse_spec_signature spec_raw_signature
        # REGEX HERE PLEASE, F%#&!@* EASY
        raw_name_and_params_types, output_type = spec_raw_signature.split('->').map(&:strip)
        name, *params_types = raw_name_and_params_types.split(/,?\s+/).map(&:strip)

        return Spectro::Spec::Signature.new(name, params_types, output_type)
      end

    end

  end

end
