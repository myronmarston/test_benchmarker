require 'ostruct'

module TestBenchmarker
  class TestBenchmark
    attr_reader :test_class, :test_name, :benchmark

    def initialize(test_class, test_name, benchmark)
      @test_class, @test_name, @benchmark = test_class, test_name, benchmark
      TestBenchmarks.add(self)
    end
  end

  class TestBenchmarks
    def self.clear
      @@classes = {}
      @@tests = []
    end

    self.clear

    def self.add(benchmark)
      test_class = benchmark.test_class

      # ignore some bogus test classes that get passed here when run in the context of a rails app...
      return if test_class =~ /(rake_test_loader|::TestCase|::IntegrationTest)/

      begin
        test_class = test_class.constantize
      rescue NameError
        return
      end
      return unless test_class.is_subclass_of?(Test::Unit::TestCase)

      @@classes[test_class] ||= OpenStruct.new
      @@classes[test_class].benchmarks ||= []
      @@classes[test_class].benchmarks << benchmark
      @@tests << benchmark
    end

    def self.results
      return if @@classes.nil? || @@classes.size == 0
      results = StringIO.new
      benchmark_attr = :real

      class_benchmarks = []
      @@classes.each do |test_class, obj|
        obj.test_count = obj.benchmarks.size
        obj.sum = obj.benchmarks.inject(0) {|sum, bmark| sum + bmark.benchmark.send(benchmark_attr)}
        obj.avg = obj.sum / obj.test_count
        obj.test_class = test_class
        class_benchmarks << obj unless obj.benchmarks.nil? || obj.benchmarks.size == 0
      end

      results.puts "\n\n#{'=' * 27} Class Benchmark Results #{'=' * 27}"
      class_benchmarks.sort {|a, b| b.avg <=> a.avg}.each_with_index do |cb, i|
        results.puts "#{i + 1}.#{' ' * (4 - (i + 1).to_s.length)} #{format("%.3f", cb.avg)} secs avg time, #{format("%.3f", cb.sum)} secs total time, #{cb.test_count} tests for: #{cb.test_class.to_s}"
      end
      results.puts "#{'=' * 79}\n\n"

      results.puts "\n\n#{'=' * 28} Test Benchmark Results #{'=' * 28}"
      @@tests.sort {|a, b| b.benchmark.send(benchmark_attr) <=> a.benchmark.send(benchmark_attr)}.each_with_index do |t, i|
        results.puts "#{i + 1}.#{' ' * (4 - (i + 1).to_s.length)} #{format("%.3f", t.benchmark.real)} secs total time for: #{t.test_name}"
      end
      results.puts "#{'=' * 80}\n\n"
      results.string
    end
  end
end