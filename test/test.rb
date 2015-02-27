require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
###################################

require 'minitest/autorun'

require './lib/sc.rb'

require_relative './minitest/test_sc.rb'
