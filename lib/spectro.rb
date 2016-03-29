require 'colorize'
require 'digest'
require 'forwardable'
require 'net/http'
require 'singleton'
require 'uri'
require 'yaml'

require 'spectro/compiler'
require 'spectro/config'
require 'spectro/database'
require 'spectro/exception'
require 'spectro/http_client'
require 'spectro/mock'
require 'spectro/spec'

# Specs driven social meta-programming
module Spectro

  # Extends the caller with the Spectro class methods on #include
  def self.included klass
    klass.extend(ClassMethods)
  end

  # Gives access to the Spectro::Config instance insde the given block
  #
  # Usage:
  #     Spectro.configure do |config|
  #       config.enable_mocks!
  #     end
  def self.configure
    yield Spectro::Config.instance
  end

  module ClassMethods

    # Register the given method name supporting the given parameters.
    #
    # Whenever Spectro::Config.mocks_enabled? is true it will try to cover unfulfilled
    # specs using the known rules as mocks.
    #
    # @param [{String, Symbol=><String, Symbol>}] interfaces hash of method names and required param names supported by the method
    def implements interfaces
      file_path = caller.first.match(/(?:^|#{Dir.pwd}\/)([^\/].*):\d+:in .+/)[1]
      interfaces.each do |method_name, required_params|
        λ = Spectro::Database.fetch(file_path, method_name, *required_params) || Spectro::Mock.create(file_path, method_name)

        raise Spectro::Exception::UndefinedMethodDefinition.new(file_path, method_name) if λ.nil?

        self.send(:define_method, method_name, &λ)
      end
    end

  end

end

# Loads the current project config, if present
load '.spectro/config' if File.exist?('.spectro/config')
