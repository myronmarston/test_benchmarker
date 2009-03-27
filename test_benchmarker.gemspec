Gem::Specification.new do |s|
  s.name = "test_benchmarker"
  s.version = "1.0.1"
  s.date = "2009-03-27"
  s.summary = "A tool for benchmarking ruby Test::Unit tests"
  s.homepage = "http://github.com/myronmarston/test_benchmarker"
  s.has_rdoc = true
  s.authors = ["Myron Marston"]
  s.email = "myron.marston@gmail.com"
  s.files = %w(CHANGELOG Manifest.txt README.rdoc Rakefile lib lib/test_benchmarker lib/test_benchmarker.rb lib/test_benchmarker/core_ext.rb lib/test_benchmarker/test_benchmarks.rb lib/test_benchmarker/test_suite.rb test test/test_core_ext.rb test/test_helper.rb test/test_test_benchmarker.rb)
  s.test_files = %w(test/test_core_ext.rb test/test_helper.rb test/test_test_benchmarker.rb)
  s.rdoc_options = ["--main", "README.rdoc",
                    "--title", "TestBenchmarker Documentation",
                    "--charset", "utf-8"]
  s.extra_rdoc_files = ["CHANGELOG", "README.rdoc"]
end