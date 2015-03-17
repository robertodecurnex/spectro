module Spectro

  class Config

    attr_accessor :mocks_enabled
 
    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :enable_mocks!, :mocks_enabled?
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
