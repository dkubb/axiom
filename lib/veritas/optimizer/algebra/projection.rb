module Veritas
  class Optimizer
    module Algebra
      class Projection < Relation::Operation::Unary

        attr_reader :header

        def initialize(*)
          super
          @header = operation.header
        end

        class UnchangedHeader < self
          def optimizable?
            header.to_a == operand.header.to_a
          end

          def optimize
            operand
          end

        end # class UnchangedHeader

        class ProjectionOperand < self
          def optimizable?
            operand.kind_of?(operation.class)
          end

          def optimize
            operation.class.new(operand.operand, header)
          end

        end # class ProjectionOperand

        class SetOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Set)
          end

          def optimize
            operand.class.new(wrap_left, wrap_right).optimize
          end

        private

          def wrap_left
            operation.class.new(operand.left, header)
          end

          def wrap_right
            operation.class.new(operand.right, header)
          end

        end # class SetOperand

        class EmptyOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Relation::Empty)
          end

          def optimize
            Veritas::Relation::Empty.new(header)
          end

        end # class EmptyOperand

        class UnoptimizedOperand < self
          def optimizable?
            !operand.equal?(operation.operand)
          end

          def optimize
            operation.class.new(operand, header)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Projection.optimizer = chain(
          UnchangedHeader,
          ProjectionOperand,
          SetOperand,
          EmptyOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Projection
    end # module Algebra
  end # class Optimizer
end # module Veritas
