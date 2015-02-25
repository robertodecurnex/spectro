module SC

  # Gives access to the current collection of
  # algorithms (lambdas) providing several ways
  # to fetch specific elements by different criterias.
  class Database
   
    # Instance delegator of SC::Database#fetch
    #
    # @param [Class] klass Class that would impement the lambda
    # @param [Symbol] method_name the method name that would be implemented
    # @param [<Symbo>] required_params parameters that would be required by the lambda
    # @return [Proc] the labda that would be implemented
    def self.fetch klass, method_name, *required_params
      SC::Database.instance.fetch(klass, method_name, *required_params)
    end

    # Returns the singleton instance of SC::Database
    #
    # @return [SC::Database] Current/new instance of the SC::Database
    def self.instance
      @@instance ||= SC::Database.new
    end
    
    # Fetches and return the target lambda based on the 
    # given class, method name and required aprameters.
    #
    # @param [Class] klass Class that would impement the lambda
    # @param [Symbol] method_name the method name that would be implemented
    # @param [<Symbo>] required_params parameters that would be required by the lambda
    # @return [Proc] the labda that would be implemented
    def fetch klass, method_name, *required_params
      # MOCK MOCK MOCK
      available_lambdas = {
        'Sample#hello:name' => lambda {|s1| "Say Hello to #{s1}"},
        'Sample#sum:n1:n2' => lambda {|i1, i2| i1 + i2},
        'Sample#rule_of_three:a:b:c' => lambda {|f1, f2, f3| f3 * f2 / f1}
      }
      available_lambdas["#{klass}##{method_name}:#{required_params.join(':')}"]
    end

  end

end
