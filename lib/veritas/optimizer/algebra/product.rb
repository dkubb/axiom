module Veritas
  class Optimizer
    module Algebra
      class Product < Relation::Operation::Combine
        class TableDeeLeft < self
          def optimizable?
            left = self.left
            left.header.empty? && !left.kind_of?(Veritas::Relation::Empty)
          end

          def optimize
            right
          end

        end # class TableDeeLeft

        class TableDeeRight < self
          def optimizable?
            right = self.right
            right.header.empty? && !right.kind_of?(Veritas::Relation::Empty)
          end

          def optimize
            left
          end

        end # class TableDeeRight

        Veritas::Algebra::Product.optimizer = chain(
          TableDeeLeft,
          TableDeeRight,
          EmptyLeft,
          EmptyRight,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Product
    end # module Algebra
  end # class Optimizer
end # module Veritas
