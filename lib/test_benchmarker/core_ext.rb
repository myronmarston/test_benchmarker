class TestBenchmarker::ClassNotFoundError < StandardError 
  attr_accessor :class_str
  def initialize(class_str)
    @class_str = class_str
  end
end

class String
  # similar to ActiveSupports constantize, but doesn't require the use of active support.
  def to_class
    ObjectSpace.each_object(Class) do |klass|
      return klass if klass.to_s == self
    end
    
    raise TestBenchmarker::ClassNotFoundError.new(self), "A class matching '#{self}' could not be found"
  end
end

class Class
  def is_subclass_of?(klass)
    return false if self == Object && klass != Object
    return true if self == klass
    return self.superclass.is_subclass_of?(klass)
  end
end