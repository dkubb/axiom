# encoding: utf-8

require 'delegate'

# This is a work-around for a bug in rubinius 2.0.0-rc1
# See: https://github.com/rubinius/rubinius/issues/2104
SimpleDelegator.class_eval do
  if instance_method(:dup).arity == 1
    def dup
      new = super
      new.__setobj__(__getobj__.dup)
      new
    end
  end
end

class LazyEnumerable < SimpleDelegator
  def size
    nil
  end
end
