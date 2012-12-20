# encoding: utf-8

require 'delegate'

class LazyEnumerable < SimpleDelegator
  def size
    nil
  end
end
