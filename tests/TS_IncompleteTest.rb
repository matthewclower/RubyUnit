#!/usr/bin/env ruby

require 'RubyUnit'

# Test Cases
RubyUnit::TestSet.new Dir["#{File.dirname(__FILE__)}/IncompleteTest/TC_*.rb"]