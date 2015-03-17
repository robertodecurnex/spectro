module Spectro

  class Spec

    # Assert representation based on input params and an expected output.
    # Meant to be used against an algorith to test its behavior.
    class Rule

      attr_accessor :output, :params
    
      # @param [<Object>] parmas set of input params
      # @param [<Object>] output expected result
      def initialize params, output
        self.output = output
        self.params = params
      end

      def == rule
        return \
          self.output == rule.output && \
          self.params == rule.params
      end

    end

  end

end
