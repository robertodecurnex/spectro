module Spectro

  module Exception

    class UndefinedMethodDefinition < ::Exception
      
      attr_accessor :file_path, :method_name
    
      def initialize file_path, method_name
        self.file_path = file_path
        self.method_name = method_name
      end

      def to_s
        "[##{self.method_name}] has not been defiend for \"#{self.file_path}\". Verify the specs at \"#{self.file_path}\" and check the `spectro compile` output for more detailed information."
      end

    end

  end

end
