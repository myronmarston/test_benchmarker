Gem::Specification.new do |s|
  s.name = "text_benchmarker"
  s.version = "0.0.1"
  s.date = "2009-03-27"
  s.summary = "A tool for benchmarking ruby Test::Unit tests"
  s.homepage = "http://github.com/myronmarston/test_benchmarker"
  s.has_rdoc = true
  s.authors = ["Myron Marston"]
  s.email = "myron.marston@gmail.com"
  s.files = %w(CHANGELOG LICENSE.txt README.rdoc Rakefile lib lib/fake_web lib/fake_web.rb lib/fake_web/ext lib/fake_web/ext/net_http.rb lib/fake_web/registry.rb lib/fake_web/responder.rb lib/fake_web/response.rb lib/fake_web/stub_socket.rb lib/fakeweb.rb test test/fixtures test/fixtures/google_response_from_curl test/fixtures/google_response_with_transfer_encoding test/fixtures/google_response_without_transfer_encoding test/fixtures/test_example.txt test/fixtures/test_txt_file test/test_allow_net_connect.rb test/test_fake_web.rb test/test_fake_web_open_uri.rb test/test_helper.rb test/test_query_string.rb)
  s.test_files = %w(test/fixtures test/fixtures/google_response_from_curl test/fixtures/google_response_with_transfer_encoding test/fixtures/google_response_without_transfer_encoding test/fixtures/test_example.txt test/fixtures/test_txt_file test/test_allow_net_connect.rb test/test_fake_web.rb test/test_fake_web_open_uri.rb test/test_helper.rb test/test_query_string.rb)
  s.rdoc_options = ["--main", "README.rdoc",
                    "--title", "TestBenchmarker Documentation",
                    "--charset", "utf-8",
                    "--line-numbers",
                    "--inline-source"]
  #s.extra_rdoc_files = ["CHANGELOG", "LICENSE.txt", "README.rdoc"]
  #s.rubyforge_project = "fakeweb"
  #s.add_development_dependency "mocha", ">= 0.9.5"
end