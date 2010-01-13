module Veritas
  module Algebra
    class Product
      class Body < Relation::Body
        def initialize(header, left, right)
          @header, @left, @right = header, left, right
        end

        def each(&block)
          @right.each do |tuple|
            CombineOperation.combine_tuples(@header, @left, tuple, &block)
          end
          self
        end

      end # class Body
    end # class Product
  end # module Algebra
end # module Veritas
