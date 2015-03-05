require_relative 'spec/parser.rb'
require_relative 'spec/rule.rb'
require_relative 'spec/signature.rb'

module SC

  class Spec
 
    attr_accessor :rules, :signature
    
    # @param [SC::Spec::Signature] signature spec signature
    # @param [<SC::Spec::Rule>] rules collection of spec rules
    def initialize signature, rules
      self.rules = rules
      self.signature = signature
    end

    def == spec
      return \
        self.signature == spec.signature && \
        self.rules == spec.rules
    end

  end

end
