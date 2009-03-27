require File.dirname(__FILE__) + '/test_helper.rb'

class Foo; end
class FooSubclass < Foo; end
class FooSubSubclass < FooSubclass; end
class Bar; end

class TestCoreExt < Test::Unit::TestCase
  def test_string_constantize
    assert_equal TestCoreExt, 'TestCoreExt'.constantize
    assert_equal FooSubSubclass, 'FooSubSubclass'.constantize
  end
  
  def test_string_constantize_for_bogus_class
    assert_raise NameError do
      'This it not the name of a class!'.constantize
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