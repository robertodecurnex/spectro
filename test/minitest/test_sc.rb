require_relative './sc/test_database.rb'
require_relative './sc/test_spec.rb'

class TestSC < Minitest::Test

   def setup
     SC::Database.new('test/files/.sc')
   end

   def test_implements
     require_relative '../files/sample'
     assert_equal 'Say Hello to Test', Sample.new.hello('Test')
   end

end
