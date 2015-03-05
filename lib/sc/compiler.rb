module SC

  # SC:Compiler is in charge of scan the projects and parse its files,
  # updating the project SC index and dumping information about the missing 
  # implementations (specs without an associated lambda)
  class Compiler

    attr_accessor :sc_path

    def initialize sc_path='.sc'   
      @@instance = self
      self.sc_path = sc_path
    end

    # Returns the singleton instance of SC::Compiler
    #
    # @return [SC::Compiler] Current/new instance of the SC::Compiler
    def self.instance
      @@instance ||= self.new
    end

    # Filters the project files keeping those making use of SC.
    # It them parses those files, check for missing implementations
    # and creates an .sc/undefined.yml with the specs of them.
    #
    # @return [SC::Compiler] self
    def compile 
      files_specs = self.targets.inject({}) do |memo, path|
        memo[path] = SC::Spec::Parser.parse(path)
      end
      #TODO: Reject specs already registered on index.yml
      #  and dump the rest of them into the undefined.yml 
      return self
    end

    # Filter project's rb files returning an Array of files 
    # containinig specs to be parsed.
    #
    # @return [<String>] array of files to be parsed
    def targets
      return %x[ grep -Pzrl --include="*.rb" "^__END__.*\\n.*spec_for" . ].split("\n")
    end

  end

end
