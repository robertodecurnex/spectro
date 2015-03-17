require_relative 'spectro/test_client'
require_relative 'spectro/test_compiler'
require_relative 'spectro/test_config'
require_relative 'spectro/test_database'
require_relative 'spectro/test_exception'
require_relative 'spectro/test_mock'
require_relative 'spectro/test_spec'

class TestSpectro < Minitest::Test

   def test_implements
     Dir.chdir('test/files') do
       require './sample'
       assert_equal 'Say Hello to Test', Sample.new.hello('Test')
     end
   end

   def test_implements_undefined
     Dir.chdir('test/files') do
       assert_raises Spectro::Exception::UndefinedMethodDefinition do 
         require './undefined_sample'
       end
     end
   end

   def test_config
     Spectro.configure do |config|
       assert_equal Spectro::Config.instance, config
     end
   end

end
