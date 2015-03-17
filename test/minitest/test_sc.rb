require_relative 'sc/test_client'
require_relative 'sc/test_compiler'
require_relative 'sc/test_config'
require_relative 'sc/test_database'
require_relative 'sc/test_exception'
require_relative 'sc/test_mock'
require_relative 'sc/test_spec'

class TestSC < Minitest::Test

   def test_implements
     Dir.chdir('test/files') do
       require './sample'
       assert_equal 'Say Hello to Test', Sample.new.hello('Test')
     end
   end

   def test_implements_undefined
     Dir.chdir('test/files') do
       assert_raises SC::Exception::UndefinedMethodDefinition do 
         require './undefined_sample'
       end
     end
   end

   def test_config
     SC.configure do |config|
       assert_equal SC::Config.instance, config
     end
   end

end
