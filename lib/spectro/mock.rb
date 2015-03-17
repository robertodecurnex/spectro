module Spectro

  class Mock

    # Creates a mock of the given method for the given file based
    # on the spec rules.
    # If mocks are not enabled it defaults to nil
    #
    # @param [String] file_path relative path of the file that requests the lambda
    # @param [Symbol] method_name the method name that would be implemented
    # @return [NilClass, Proc] the mock as Proc or nil if mocks are disabled
    def self.create file_path, method_name
      return nil unless Spectro::Config.mocks_enabled?
     
      spec = Spectro::Spec::Parser.parse(file_path).detect do |spec|
        spec.signature.name == method_name.to_s
      end
      
      param_names = Array.new(spec.signature.params_types.count) do |index|
        ('a'.ord+index).chr
      end
      
      responses = spec.rules.inject({}) do |memo, rule|
        memo[rule.params] = rule.output  
        memo
      end
      
      return eval "
        lambda do |#{param_names.join(',')}|
          if !responses.has_key?([#{param_names.join(',')}])
            raise Spectro::Exception::UnknownMockResponse.new(file_path, method_name)          
          end

          return responses[[#{param_names.join(',')}]] 
        end
      "
    end

  end

end
