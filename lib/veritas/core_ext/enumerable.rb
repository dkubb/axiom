module Enumerable

  # Add Enumerable#take for Ruby 1.8.6
  def take(n)
    array = []
    each do |elem|
      array << elem
      break if array.size >= n
    end unless n <= 0
    array
  end unless method_defined? :take

  # Add Enumerable#drop for Ruby 1.8.6
  def drop(n)
    ary = to_a
    return [] if n > ary.size
    ary[n...ary.size]
  end unless method_defined? :drop

end
