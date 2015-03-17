require 'spectro'
require 'spectro/spec/parser'
require 'yaml/store'

module Spectro

  # Spectro:Compiler is in charge of spectroan the projects and parse its files,
  # updating the project Spectro index and dumping information about the missing 
  # implementations (specs without an associated lambda)
  class Compiler

    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :compile
    end

    # Filters the project files keeping those making use of Spectro.
    # It them parses those files, check for missing implementations
    # and creates an .spectro/undefined.yml with the specs of them.
    #
    # @return [Spectro::Compiler] self
    def compile 
      undefined_yaml = YAML::Store.new(".spectro/undefined.yml")
      undefined_yaml.transaction do
        targets().map do |path|
          missing_specs = missing_specs_from_file(path)

          next if missing_specs.empty?
           
          undefined_yaml[path] = missing_specs
        end
      end
     
      return self
    end

  private

    # Parse the specs on the given file path and return those specs 
    # that have not been fulfilled or need to be updated.
    #
    # @param [String] path target file path
    # @return [<Spectro::Spec>] collection of specs not fulfilled or out of date
    def missing_specs_from_file(path)
      Spectro::Spec::Parser.parse(path).select do |spec|
        index_spec = Spectro::Database.index[path] && Spectro::Database.index[path][spec.signature.name]
        index_spec.nil? || index_spec['spec_md5'] != spec.md5
      end
    end

    # Filter project's rb files returning an Array of files 
    # containinig specs to be parsed.
    #
    # @return [<String>] array of files to be parsed
    def targets
      return %x[ grep -Pzrl --include="*.rb" "^__END__.*\\n.*spec_for" . ].split("\n").collect do |path|
        path[2..-1] 
      end
    end

  end

end
