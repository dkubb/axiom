module Veritas
  class Optimizer
    module Relation
      module Operation
        class Binary < Optimizer
          attr_reader :left, :right

          def initialize(*)
            super
            @left  = optimize_left
            @right = optimize_right
          end

        private

          def optimize_left
            operation.left.optimize
          end

          def optimize_right
            operation.right.optimize
          end

          module EmptyLeft
            def optimizable?
              left.kind_of?(Veritas::Relation::Empty)
            end

          end # module EmptyLeft

          module EmptyRight
            def optimizable?
              right.kind_of?(Veritas::Relation::Empty)
            end

          end # module EmptyRight

          module EqualOperands
            def optimizable?
              left.eql?(right)
            end

          end # module EqualOperands

          class MaterializedOperand < self
            def optimizable?
              left.kind_of?(Veritas::Relation::Materialized) &&
              right.kind_of?(Veritas::Relation::Materialized)
            end

            # TODO: add Relation#materialize and change to use it
            def optimize
              operation = self.operation
              Veritas::Relation::Materialized.new(operation.header, operation.to_a)
            end

          end # class MaterializedOperand

          class UnoptimizedOperand < self
            def optimizable?
              operation = self.operation
              !left.equal?(operation.left) ||
              !right.equal?(operation.right)
            end

            def optimize
              operation.class.new(left, right)
            end

          end # class UnoptimizedOperand
        end # class Binary
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
