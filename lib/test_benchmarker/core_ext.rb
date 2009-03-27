class String
  # ported from ActiveSupport, so that we don't have to require all of active support for this gem.
  # http://github.com/rails/rails/blob/dd2eb1ea7c34eb6496feaf7e42100f37a8dae76b/activesupport/lib/active_support/inflector.rb#L335-376  
  # Ruby 1.9 introduces an inherit argument for Module#const_get and
  # #const_defined? and changes their default behavior.
  if Module.method(:const_get).arity == 1
    # Tries to find a constant with the name specified in the argument string:
    #
    #   "Module".constantize     # => Module
    #   "Test::Unit".constantize # => Test::Unit
    #
    # The name is assumed to be the one of a top-level constant, no matter whether
    # it starts with "::" or not. No lexical context is taken into account:
    #
    #   C = 'outside'
    #   module M
    #     C = 'inside'
    #     C               # => 'inside'
    #     "C".constantize # => 'outside', same as ::C
    #   end
    #
    # NameError is raised when the name is not in CamelCase or the constant is
    # unknown.
    def constantize
      names = self.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  else
    def constantize
      names = self.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_get(name, false) || constant.const_missing(name)
      end
      constant
    end
  end
end

class Class
  def is_subclass_of?(klass)
    return false if self == Object && klass != Object
    return true if self == klass
    return self.superclass.is_subclass_of?(klass)
  end
end