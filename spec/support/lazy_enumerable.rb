# encoding: utf-8

class LazyEnumerable < BasicObject
  def initialize(enumerable = [])
    @enumerable = enumerable
  end

  def size
    nil
  end

private

  def method_missing(*args, &block)
    @enumerable.__send__(*args, &block)
  end

end
