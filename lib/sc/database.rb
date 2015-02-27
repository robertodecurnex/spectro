module SC

  # Gives access to the current collection of
  # algorithms (lambdas) providing several ways
  # to fetch specific elements by different criterias.
  class Database

    attr_accessor :cache, :index, :sc_path

    def initialize sc_path='./.sc'
      @@instance = self
      self.cache = {}
      self.sc_path = sc_path
      self.index = YAML.load_file("#{self.sc_path}/index.yml")
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

    # Returns the singleton instance of SC::Database
    #
    # @return [SC::Database] Current/new instance of the SC::Database
    def self.instance
      @@instance ||= self.new
    end
    
    # Fetches and return the target lambda based on the 
    # given class, method name and required aprameters.
    #
    # @param [Class] klass Class that would impement the lambda
    # @param [Symbol] method_name the method name that would be implemented
    # @param [<Symbo>] required_params parameters that would be required by the lambda
    # @return [Proc] the labda that would be implemented
    def fetch klass, method_name, *required_params
      λ_id = self.index["#{klass}"]["#{method_name}:#{required_params.count}"]
      return self.cache[λ_id] ||= eval(File.read("#{self.sc_path}/cache/#{λ_id}.rb"))
    end

  end

end
