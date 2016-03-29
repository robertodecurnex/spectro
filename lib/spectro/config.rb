module Spectro

  class Config

    API_HOSTNAME = 'localhost:9292'

    attr_accessor :mocks_enabled

    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :api_hostname, :api_hostname=, :enable_mocks!, :mocks_enabled?
    end

    # Returns the API Hostname from the config
    # or the default if missin
    #
    # @return [String] the API Hostname
    def api_hostname
      return @api_hostname || API_HOSTNAME
    end

    # Sets a custom API Hostname
    #
    # @param [String|NilClass] hostname the custom hostname or `nil` for the default
    # @return [String|NilClass]
    def api_hostname= hostname
      @api_hostname = hostname
    end

    # Sets mocks_enabled to true
    #
    # @return [Spectro::Config] self
    def enable_mocks!
      self.mocks_enabled = true
      return self
    end

    # Returns the current mocks policy (enabled or disabled)
    #
    # @return [TrueClass, FalseClass] whether mocks are enabled or not
    def mocks_enabled?
      return !!self.mocks_enabled
    end

  end

end
