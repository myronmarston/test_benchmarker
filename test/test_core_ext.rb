require File.dirname(__FILE__) + '/test_helper.rb'

class Foo; end
class FooSubclass < Foo; end
class FooSubSubclass < FooSubclass; end
class Bar; end

class TestCoreExt < Test::Unit::TestCase
  def test_string_to_class
    assert_equal TestCoreExt, 'TestCoreExt'.to_class
    assert_equal FooSubSubclass, 'FooSubSubclass'.to_class
  end
  
  def test_string_to_class_not_found
    assert_raise TestBenchmarker::ClassNotFoundError do
      'This it not the name of a class!'.to_class
    end
  end
  
  def test_class_is_subclass_of
    assert FooSubclass.is_subclass_of?(Foo)
    assert FooSubclass.is_subclass_of?(Object)
    
    assert FooSubSubclass.is_subclass_of?(FooSubclass)
    assert FooSubSubclass.is_subclass_of?(Foo)
    assert FooSubSubclass.is_subclass_of?(Object)
  end
  
  def test_class_is_not_subclass_of
    assert !Bar.is_subclass_of?(Foo)
  end
end