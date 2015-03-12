require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
###################################

require 'fileutils'
require 'minitest/autorun'
require 'yaml'

require './lib/sc.rb'
require './lib/sc/client.rb'
require './lib/sc/compiler.rb'
require './lib/sc/spec/parser.rb'

require_relative './minitest/test_sc.rb'
