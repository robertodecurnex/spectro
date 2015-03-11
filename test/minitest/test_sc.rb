require_relative './sc/test_compiler.rb'
require_relative './sc/test_database.rb'
require_relative './sc/test_spec.rb'

class TestSC < Minitest::Test

   def setup
   end

   def test_implements
     Dir.chdir('test/files') do
       require './sample.rb'
       assert_equal 'Say Hello to Test', Sample.new.hello('Test')
     end
   end

end
