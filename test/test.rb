require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
###################################

require 'fileutils'
require 'minitest/autorun'
require 'yaml'

require './lib/sc.rb'

require_relative './minitest/test_sc.rb'
