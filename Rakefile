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

desc %{Update ".manifest" with the latest list of project filenames. Respect\
.gitignore by excluding everything that git ignores. Update `files` and\
`test_files` arrays in "*.gemspec" file if it's present.}
task :manifest do
  list = Dir['**/*'].sort
  spec_file = Dir['*.gemspec'].first
  list -= [spec_file] if spec_file
 
  if File.exist?('.gitignore')
    File.read('.gitignore').each_line do |glob|
      glob = glob.chomp.sub(/^\//, '')
      list -= Dir[glob]
      list -= Dir["#{glob}/**/*"] if File.directory?(glob) and !File.symlink?(glob)
      puts "excluding #{glob}"
    end
  end
 
  if spec_file
    spec = File.read spec_file
    spec.gsub! /^(\s* s.(test_)?files \s* = \s* )( \[ [^\]]* \] | %w\( [^)]* \) )/mx do
      assignment = $1
      bunch = $2 ? list.grep(/^test\//) : list
      '%s%%w(%s)' % [assignment, bunch.join(' ')]
    end
 
    File.open(spec_file, 'w') {|f| f << spec }
  end
  File.open('manifest.txt', 'w') {|f| f << list.join("\n") }
end