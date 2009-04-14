require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => :test

desc "Run All Tests"
Rake::TestTask.new :test do |test|
  test.test_files = ["test/**/*.rb"]
  test.verbose = true
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "test_benchmarker"
    gemspec.summary = "A tool for benchmarking ruby Test::Unit tests."
    gemspec.email = "myron.marston@gmail.com"
    gemspec.homepage = "http://github.com/myronmarston/test_benchmarker/"
    gemspec.description = "A tool for benchmarking ruby Test::Unit tests."
    gemspec.authors = ["Myron Marston"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end