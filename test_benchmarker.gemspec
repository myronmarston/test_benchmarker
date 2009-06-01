# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{test_benchmarker}
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Myron Marston"]
  s.date = %q{2009-06-01}
  s.description = %q{A tool for benchmarking ruby Test::Unit tests.}
  s.email = %q{myron.marston@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["Manifest.txt", "README.rdoc", "VERSION.yml", "lib/test_benchmarker", "lib/test_benchmarker/core_ext.rb", "lib/test_benchmarker/test_benchmarks.rb", "lib/test_benchmarker/test_suite.rb", "lib/test_benchmarker.rb", "test/test_core_ext.rb", "test/test_helper.rb", "test/test_test_benchmarker.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/myronmarston/test_benchmarker/}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A tool for benchmarking ruby Test::Unit tests.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
