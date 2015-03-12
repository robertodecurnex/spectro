require_relative 'spec/rule.rb'
require_relative 'spec/signature.rb'

module SC

  class Spec
 
    attr_accessor :md5, :rules, :signature
   
    # @param [String] spec md5
    # @param [SC::Spec::Signature] signature spec signature
    # @param [<SC::Spec::Rule>] rules collection of spec rules
    def initialize md5, signature, rules
      self.md5 = md5
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
