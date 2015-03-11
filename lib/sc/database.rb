module SC

  # Gives access to the current collection of
  # algorithms (lambdas) providing several ways
  # to fetch specific elements by different criterias.
  class Database

    attr_accessor :cache

    def initialize
      @@instance = self
      self.cache = {}
    end

    def index
      @index ||= YAML.load_file('./.sc/index.yml')
    end

    # Instance delegator of SC::Database#fetch
    #
    # @param [Class] klass Class that would impement the lambda
    # @param [Symbol] method_name the method name that would be implemented
    # @param [<Symbo>] required_params parameters that would be required by the lambda
    # @return [Proc] the labda that would be implemented
    def self.fetch klass, method_name, *required_params
      self.instance.fetch(klass, method_name, *required_params)
    end

    # Instane delegator of SC::Database#index
    #
    # @return [Hash] the parsed index as Hash
    def self.index
      self.instance.index
    end

    # Returns the singleton instance of SC::Database
    #
    # @return [SC::Database] Current/new instance of the SC::Database
    def self.instance
      @@instance ||= self.new
    end
    
    # Fetches and return the target lambda based on the 
    # given class, method name and required aprameters.
    #
    # @param [String] file_path relative path of the file that requests the lambda
    # @param [Symbol] method_name the method name that would be implemented
    # @param [<Symbol>] required_params parameters that would be required by the lambda
    # @return [Proc] the labda that would be implemented
    def fetch file_path, method_name, *required_params
      λ_id = self.index["#{file_path}"]["#{method_name}"]['lambda_id']
      return self.cache[λ_id] ||= eval(File.read(".sc/cache/#{λ_id}.rb"))
    end

  end

end
