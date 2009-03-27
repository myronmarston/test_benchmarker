$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module TestBenchmarker
  VERSION = '0.0.1'
end

require 'lib/test_benchmarker/test_benchmarks'
require 'lib/test_benchmarker/test_suite'
require 'lib/test_benchmarker/core_ext'