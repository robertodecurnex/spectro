module Spectro

  module Exception

    class UnknownMockResponse < ::Exception
      
      attr_accessor :file_path, :method_name
    
      def initialize file_path, method_name
        self.file_path = file_path
        self.method_name = method_name
      end

      def to_s
        "[##{self.method_name}] mock has not response defined for the given params. Verify the specs at \"#{self.file_path}\"."
      end

    end

  end

end
