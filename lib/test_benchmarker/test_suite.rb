require 'benchmark'

if ENV['BENCHMARK_TESTS'] || ENV['TEST_BENCHMARKS_FILE']
  class Test::Unit::TestSuite
    @@run_count = 0

    def run(result, &progress_block)
      @@run_count += 1
      begin
        yield(STARTED, name)
        @tests.each do |test|
          TestBenchmarker::TestBenchmark.new(self.name, test.name, Benchmark.measure { test.run(result, &progress_block) })
        end
        yield(FINISHED, name)
      ensure
        @@run_count -= 1
        # print the results as we're exiting the very last test run...
        if @@run_count == 0
          results = TestBenchmarker::TestBenchmarks.results
          if ENV['TEST_BENCHMARKS_FILE']
            File.open(ENV['TEST_BENCHMARKS_FILE'], 'w') { |f| f << results }
          else
            puts results
          end
        end
      end
    end
  end
end