require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
###################################

require 'fileutils'
require 'minitest/autorun'
require 'yaml'

require 'sc'
require 'sc/client'
require 'sc/compiler'
require 'sc/spec/parser'

require_relative 'minitest/test_sc'
