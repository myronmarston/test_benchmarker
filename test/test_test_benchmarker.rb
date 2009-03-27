require File.dirname(__FILE__) + '/test_helper.rb'

class Foo; end
class Class1 < Test::Unit::TestCase 
  def test_truth; end
end

class Class2 < Test::Unit::TestCase
  def test_truth; end
end

class Class3 < Test::Unit::TestCase
  def test_truth; end
end

class Class4; end

class TestTestBenchmarker < Test::Unit::TestCase
  def setup
    1.upto(3) do |class_speed|
      1.upto(3) do |test_speed|
        speed = class_speed * 0.01 + test_speed * 0.001
        TestBenchmarker::TestBenchmark.new("Class#{class_speed}", "test_#{test_speed} (Class#{class_speed})", ::Benchmark.measure { sleep speed })
      end
    end
    
    TestBenchmarker::TestBenchmark.new("Class4", "test_1 (Class4)", ::Benchmark.measure { sleep 0.01 })
    
    @benchmarked_classes = TestBenchmarker::TestBenchmarks.send(:class_variable_get, '@@classes')
    @benchmarked_tests = TestBenchmarker::TestBenchmarks.send(:class_variable_get, '@@tests').map(&:test_name)
    @out, @err = util_capture { TestBenchmarker::TestBenchmarks.print_results }
  end
  
  def teardown
    TestBenchmarker::TestBenchmarks.clear
  end
  
  def test_is_subclass_of
    assert TestBenchmarker::TestBenchmarks.is_subclass_of?(Class1, Test::Unit::TestCase)
  end
  
  def test_is_not_subclass
    assert !TestBenchmarker::TestBenchmarks.is_subclass_of?(Class4, Test::Unit::TestCase)
  end
  
  def test_has_expected_benchmarked_classes
    assert_equal 3, @benchmarked_classes.keys.size
    
    assert @benchmarked_classes.keys.include?(Class1)
    assert @benchmarked_classes.keys.include?(Class2)
    assert @benchmarked_classes.keys.include?(Class3)
  end
  
  def test_does_not_have_classes_not_descended_from_test_unit_testcase
    assert !@benchmarked_classes.keys.include?(Class4)
  end
  
  def test_has_expected_benchmarked_tests
    assert_equal 9, @benchmarked_tests.size
    
    assert @benchmarked_tests.include?('test_1 (Class1)')
    assert @benchmarked_tests.include?('test_2 (Class1)')
    assert @benchmarked_tests.include?('test_3 (Class1)')
    assert @benchmarked_tests.include?('test_1 (Class2)')
    assert @benchmarked_tests.include?('test_2 (Class2)')
    assert @benchmarked_tests.include?('test_3 (Class2)')
    assert @benchmarked_tests.include?('test_1 (Class3)')
    assert @benchmarked_tests.include?('test_2 (Class3)')
    assert @benchmarked_tests.include?('test_3 (Class3)')
  end
  
  def test_does_not_have_tests_not_descended_from_test_unit_testcase
    assert !@benchmarked_tests.include?("test_1 (Class4)")
  end
  
  def test_class_benchmark_results
    # should be in order from slowest to fastest
    assert_match class_benchmark_regex('Class3', 1), @out
    assert_match class_benchmark_regex('Class2', 2), @out
    assert_match class_benchmark_regex('Class1', 3), @out
  end
  
  def test_test_benchmark_results
    # should be in order from slowest to fastest
    assert_match test_benchmark_regex('test_3 (Class3)', 1), @out
    assert_match test_benchmark_regex('test_2 (Class3)', 2), @out
    assert_match test_benchmark_regex('test_1 (Class3)', 3), @out
    assert_match test_benchmark_regex('test_3 (Class2)', 4), @out
    assert_match test_benchmark_regex('test_2 (Class2)', 5), @out
    assert_match test_benchmark_regex('test_1 (Class2)', 6), @out
    assert_match test_benchmark_regex('test_3 (Class1)', 7), @out
    assert_match test_benchmark_regex('test_2 (Class1)', 8), @out
    assert_match test_benchmark_regex('test_1 (Class1)', 9), @out
  end
  
  private
  
  # borrowed from zentest assertions...
  def util_capture
    require 'stringio'
    orig_stdout = $stdout.dup
    orig_stderr = $stderr.dup
    captured_stdout = StringIO.new
    captured_stderr = StringIO.new
    $stdout = captured_stdout
    $stderr = captured_stderr
    yield
    captured_stdout.rewind
    captured_stderr.rewind
    return captured_stdout.string, captured_stderr.string
  ensure
    $stdout = orig_stdout
    $stderr = orig_stderr
  end
  
  def class_benchmark_regex(class_name, slowness_ranking)
    # http://rubular.com/regexes/6815
    /^#{slowness_ranking}\.\s+[\d\.]+ secs avg time, [\d\.]+ secs total time, [\d]+ tests for: #{Regexp.escape(class_name)}$/
  end
  
  def test_benchmark_regex(test_name, slowness_ranking)
    # http://rubular.com/regexes/6816
    /^#{slowness_ranking}.\s+[\d\.]+ secs total time for: #{Regexp.escape(test_name)}$/
  end
end