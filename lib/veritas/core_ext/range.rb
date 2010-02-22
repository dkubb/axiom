class Range
  def to_inclusive
    if exclude_end?
      self.class.new(first, last.pred)
    else
      self
    end
  end unless method_defined? :to_inclusive

  def to_exclusive
    if exclude_end?
      self
    else
      self.class.new(first, last.succ, true)
    end
  end unless method_defined? :to_exclusive

  def overlaps?(other)
    include?(other.first) || other.include?(first)
  end unless method_defined? :overlaps?
end
