module SC

  class Spec
    
    # Representation of the required input/output types 
    class Signature
    
      attr_accessor :name, :output_type, :params_types
    
      # @param [String] name local name of the algorith (not sure if needed)
      # @param [<String>] param_types types of the expected input params
      # @param [String] output_type type of the expected output
      def initialize name, params_types, output_type
        self.name = name
        self.output_type = output_type
        self.params_types = params_types
      end

      def == signature
        return \
          self.name == signature.name && \
          self.output_type == signature.output_type && \
          self.params_types == signature.params_types
      end

    end

  end

end
