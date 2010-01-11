module Enumerable

  # Add Enumerable#take for Ruby 1.8.6
  def take(limit)
    assert_positive_size(limit, :take)
    array = []
    each_with_index do |entry, index|
      break if index == limit
      array << entry
    end
    array
  end unless method_defined? :take

  # Add Enumerable#drop for Ruby 1.8.6
  def drop(offset)
    assert_positive_size(offset, :drop)
    to_a[offset..-1] || []
  end unless method_defined? :drop

private

  def assert_positive_size(number, method)
    if number < 0
      raise ArgumentError, "attempt to #{method} negative size"
    end
  end

end
