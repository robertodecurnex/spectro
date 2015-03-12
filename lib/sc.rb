require 'digest'
require 'forwardable'
require 'singleton'
require 'yaml'

require_relative 'sc/database.rb'
require_relative 'sc/spec.rb'

# Specs driven social meta-programming
module SC

  # Extends the caller with the SC class methods on #include
  def self.included klass
    klass.extend(ClassMethods)
  end
  
  module ClassMethods

    # Register the given method name supporting the given parameters.
    #
    # @param [{String, Symbol=><String, Symbol>}] interfaces hash of method names and required param names that the method supports
    def implements interfaces
      file_path = caller.first.match(/#{Dir.pwd}\/(.+):\d+:in .+/)[1]
      interfaces.each do |method_name, required_params|
        λ = SC::Database.fetch(file_path, method_name, *required_params) 
        self.send(:define_method, method_name, &λ)
      end
    end

  end

end

