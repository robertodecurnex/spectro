module Spectro

  # Gives access to the current collection of
  # algorithms (lambdas) providing several ways
  # to fetch specific elements by different criteria.
  class Database

    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :fetch, :index
    end

    attr_accessor :cache

    def initialize
      self.cache = {}
    end

    # Lazy loads the index.yml and returns it
    #
    # @return [Hash] the parsed index.yml
    def index
      return @index ||= load_index()
    end

    # Sets the index cache to nil
    # Just in case you want the database to parse the file once again
    def reset_index
      @index = nil
    end

    # Fetches and returns the target lambda based on the
    # given class, method name and required aprameters.
    #
    # @param [String] file_path relative path of the file that requests the lambda
    # @param [Symbol] method_name the method name that would be implemented
    # @param [<Symbol>] required_params parameters that would be required by the lambda
    # @return [Proc] the labda that would be implemented
    def fetch file_path, method_name, *required_params
      if self.index["#{file_path}"].nil? || self.index["#{file_path}"]["#{method_name}"].nil?
        return nil
      end
      λ_id = self.index["#{file_path}"]["#{method_name}"]['lambda_id']
      return self.cache[λ_id] ||= eval(File.read(".spectro/cache/#{λ_id}.rb"))
    end

    private

      # Loads and returns the current project index or returns
      # an empty one if not found
      def load_index
        return {} if !File.exist?('.spectro/index.yml')

        return YAML.load_file('.spectro/index.yml') || {}
      end

  end

end
