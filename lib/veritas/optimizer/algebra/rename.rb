module Veritas
  class Optimizer
    module Algebra
      class Rename < Relation::Operation::Unary
        attr_reader :aliases

        def initialize(*)
          super
          @aliases = self.class.union_aliases(operation.aliases, operand)
        end

      private

        def wrap_operand
          operation.class.new(operand.operand, aliases)
        end

        def self.union_aliases(aliases, operand)
          if operand.respond_to?(:aliases)
            aliases.union(operand.aliases)
          else
            aliases
          end
        end

        class RenameOperandAndEmptyAliases < self
          def optimizable?
            operand.kind_of?(operation.class) && aliases.empty?
          end

          def optimize
            operand.operand
          end

        end # class RenameOperandAndEmptyAliases

        class RenameOperandAndAnyAliases < self
          def optimizable?
            operand.kind_of?(operation.class) && aliases.any?
          end

          def optimize
            operation.class.new(operand.operand, aliases)
          end

        end # class RenameOperandAndAnyAliases

        class ProjectionOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Algebra::Projection)
          end

          def optimize
            operand.class.new(wrap_operand, operation.header).optimize
          end

        end # class ProjectionOperand

        class RestrictionOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Algebra::Restriction)
          end

          def optimize
            operand.class.new(wrap_operand, rename_predicate).optimize
          end

        private

          def rename_predicate
            operand.predicate.rename(aliases)
          end

        end # class RestrictionOperand

        class SetOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Set)
          end

          def optimize
            operand.class.new(wrap_left, wrap_right).optimize
          end

        private

          def wrap_left
            operation.class.new(operand.left, aliases)
          end

          def wrap_right
            operation.class.new(operand.right, aliases)
          end

        end # class SetOperand

        class ReverseOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Reverse)
          end

          def optimize
            operand.class.new(wrap_operand).optimize
          end

        end # class ReverseOperand

        class OrderOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Order)
          end

          def optimize
            operand.class.new(wrap_operand, operation.directions).optimize
          end

        end # class OrderOperand

        class LimitOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Limit)
          end

          def optimize
            operand = self.operand
            operand.class.new(wrap_operand, operand.to_i).optimize
          end

        end # class LimitOperand

        class OffsetOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Offset)
          end

          def optimize
            operand = self.operand
            operand.class.new(wrap_operand, operand.to_i).optimize
          end

        end # class OffsetOperand

        class EmptyOperand < self
          def optimizable?
            operand.kind_of?(Veritas::Relation::Empty)
          end

          def optimize
            Veritas::Relation::Empty.new(operation.header)
          end

        end # class EmptyOperand

        class UnoptimizedOperand < self
          def optimizable?
            operation = self.operation
            !operand.equal?(operation.operand) ||
            !aliases.equal?(operation.aliases)
          end

          def optimize
            operation.class.new(operand, aliases)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Rename.optimizer = chain(
          RenameOperandAndEmptyAliases,
          RenameOperandAndAnyAliases,
          ProjectionOperand,
          RestrictionOperand,
          SetOperand,
          ReverseOperand,
          OrderOperand,
          LimitOperand,
          OffsetOperand,
          EmptyOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Rename
    end # module Algebra
  end # class Optimizer
end # module Veritas
