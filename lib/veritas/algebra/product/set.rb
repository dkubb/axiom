module Veritas
  module Algebra
    class Product
      class Set
        def initialize(header, left, right)
          @header, @left, @right = header, left, right
        end

        def each(&block)
          @right.each do |tuple|
            CombineOperation.combine_tuples(@header, @left, tuple, &block)
          end
          self
        end

      end # class Set
    end # class Product
  end # module Algebra
end # module Veritas
