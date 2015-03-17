require 'digest'
require 'forwardable'
require 'singleton'
require 'yaml'

require 'sc/config'
require 'sc/database'
require 'sc/exception'
require 'sc/mock'
require 'sc/spec'

# Specs driven social meta-programming
module SC

  # Extends the caller with the SC class methods on #include
  def self.included klass
    klass.extend(ClassMethods)
  end
  
  # Gives access to the SC::Config instance insde the given block
  #
  # Usage:
  #     SC.configure do |config|
  #       config.enable_mocks!
  #     end
  def self.configure 
    yield SC::Config.instance
  end
  
  module ClassMethods

    # Register the given method name supporting the given parameters.
    #
    # Whenever SC::Config.mocks_enabled? is true it will try to cover unfulfilled 
    # specs using the knwon rules as mocks. 
    #
    # @param [{String, Symbol=><String, Symbol>}] interfaces hash of method names and required param names that the method supports
    def implements interfaces
      file_path = caller.first.match(/#{Dir.pwd}\/(.+):\d+:in .+/)[1]
      interfaces.each do |method_name, required_params|
        λ = SC::Database.fetch(file_path, method_name, *required_params) || SC::Mock.create(file_path, method_name)

        raise SC::Exception::UndefinedMethodDefinition.new(file_path, method_name) if λ.nil?

        self.send(:define_method, method_name, &λ)
      end
    end

  end

end

