module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Rename optimizations
      class Rename < Relation::Operation::Unary

        # The renamed header
        #
        # @return [Header]
        #
        # @api private
        attr_reader :header

        # The optimized aliases
        #
        # @return [Rename::Aliases]
        #
        # @api private
        attr_reader :aliases

        # Initialize an Rename optimizer
        #
        # @param [Relation] operation
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operation)
          super
          @header  = operation.header
          @aliases = self.class.union_aliases(operation.aliases, operand)
        end

      private

        # Wrap the operand's operand in a Rename
        #
        # @return [Rename]
        #
        # @api private
        def wrap_operand
          operation.class.new(operand.operand, aliases)
        end

        # Union the operaation aliases with any operand aliases
        #
        # @param [Rename::Aliases]
        #   the original aliases
        # @param [Relation]
        #   the operand
        #
        # @return [Rename::Aliases]
        #
        # @api private
        def self.union_aliases(aliases, operand)
          if operand.respond_to?(:aliases)
            aliases.union(operand.aliases)
          else
            aliases
          end
        end

        # Optimize when the operand is a Rename with aliases that cancel out
        class RenameOperandAndEmptyAliases < self

          # Test if the operand is a Rename with aliases that cancel out
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(operation.class) && aliases.empty?
          end

          # A Rename wrapping a Rename with aliases that cancel out is a noop
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            operand.operand
          end

        end # class RenameOperandAndEmptyAliases

        # Optimize when the operand is a Rename
        class RenameOperand < self

          # Test if the operand is a Rename
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(operation.class)
          end

          # Flatten nested Renames into a single Rename
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            operation.class.new(operand.operand, aliases)
          end

        end # class RenameOperand

        # Optimize when the operand is a Projection
        class ProjectionOperand < self

          # Test if the operand is a Projection
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Algebra::Projection)
          end

          # Wrap the Rename in a Projection
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            operand.class.new(wrap_operand, header).optimize
          end

        end # class ProjectionOperand

        # Optimize when the operand is a Restriction
        class RestrictionOperand < self

          # Test if the operand is a Restriction
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Algebra::Restriction)
          end

          # Wrap the Rename in a Restriction
          #
          # @return [Restriction]
          #
          # @api private
          def optimize
            operand.class.new(wrap_operand, rename_predicate).optimize
          end

        private

          # Rename the operand predicate
          #
          # @return [Expression]
          #
          # @api private
          def rename_predicate
            operand.predicate.rename(aliases)
          end

        end # class RestrictionOperand

        # Optimize when the operand is a Set
        class SetOperand < self

          # Test if the operand is a Set
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Set)
          end

          # Wrap each operand in the Set in a Rename
          #
          # @return [Set]
          #
          # @api private
          def optimize
            operand.class.new(wrap_left, wrap_right).optimize
          end

        private

          # Utility method to wrap the left operand in a Rename
          #
          # @return [Rename]
          #
          # @api private
          def wrap_left
            operation.class.new(operand.left, aliases)
          end

          # Utility method to wrap the right operand in a Rename
          #
          # @return [Rename]
          #
          # @api private
          def wrap_right
            operation.class.new(operand.right, aliases)
          end

        end # class SetOperand

        # Optimize when the operand is a Reverse
        class ReverseOperand < self

          # Test if the operand is a Reverse
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Reverse)
          end

          # Wrap the Rename in a Reverse
          #
          # @return [Reverse]
          #
          # @api private
          def optimize
            operand.class.new(wrap_operand).optimize
          end

        end # class ReverseOperand

        # Optimize when the operand is an Order
        class OrderOperand < self

          # Test if the operand is an Order
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Order)
          end

          # Wrap the Rename in an Order
          #
          # @return [Order]
          #
          # @api private
          def optimize
            operand.class.new(wrap_operand, operation.directions).optimize
          end

        end # class OrderOperand

        # Optimize when the operand is a Limit
        class LimitOperand < self

          # Test if the operand is a Limit
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Limit)
          end

          # Wrap the Rename in a Limit
          #
          # @return [Limit]
          #
          # @api private
          def optimize
            operand = self.operand
            operand.class.new(wrap_operand, operand.to_i).optimize
          end

        end # class LimitOperand

        # Optimize when the operand is an Offset
        class OffsetOperand < self

          # Test if the operand is an Offset
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Offset)
          end

          # Wrap the Rename in an Offset
          #
          # @return [Offset]
          #
          # @api private
          def optimize
            operand = self.operand
            operand.class.new(wrap_operand, operand.to_i).optimize
          end

        end # class OffsetOperand

        # Optimize when the operand is Empty
        class EmptyOperand < self

          # Test if the operand is empty
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Empty)
          end

          # Return a new Empty relation with the operation's headers
          #
          # @return [Empty]
          #
          # @api private
          def optimize
            Veritas::Relation::Empty.new(header)
          end

        end # class EmptyOperand

        # Optimize when operand is optimizable
        class UnoptimizedOperand < self

          # Test if the operand is unoptimized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operation = self.operation
            !operand.equal?(operation.operand) ||
            !aliases.equal?(operation.aliases)
          end

          # Return a Rename with an optimized operand
          #
          # @return [Rename]
          #
          # @api private
          def optimize
            operation.class.new(operand, aliases)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Rename.optimizer = chain(
          RenameOperandAndEmptyAliases,
          RenameOperand,
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
