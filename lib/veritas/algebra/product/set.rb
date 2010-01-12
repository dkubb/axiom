module Veritas
  module Algebra
    class Product
      class Set
        def initialize(left, right)
          @left, @right = left, right
        end

        def each(&block)
          @right.each do |right_tuple|
            CombineOperation.combine_tuples(@left, right_tuple, &block)
          end
          self
        end

      end # class Set
    end # class Product
  end # module Algebra
end # module Veritas
