module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Restriction optimizations
      class Restriction < Relation::Operation::Unary

        # The optimized predicate
        #
        # @return [Expression]
        #
        # @api private
        attr_reader :predicate

        # Initialize an Restriction optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @predicate = self.class.optimize_predicate(operation.predicate)
        end

      private

        # Wrap the operand's operand in a Restriction
        #
        # @return [Restriction]
        #
        # @api private
        def wrap_operand
          operation.class.new(operand.operand, predicate).optimize
        end

        # Optimize the predicate if possible
        #
        # @param [Expression] predicate
        #
        # @return [Expression]
        #
        # @api private
        def self.optimize_predicate(predicate)
          predicate.respond_to?(:optimize) ? predicate.optimize : predicate
        end

        # Optimize when the predicate is true
        class TruePredicate < self

          # Test if the predicate is true
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            predicate.equal?(Veritas::Logic::Proposition::True.instance)
          end

          # A Restriction with a true predicate is a noop
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            operand
          end

        end # class TruePredicate

        # Optimize when the predicate is false
        class FalsePredicate < self

          # Test if the predicate is false
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            predicate.equal?(Veritas::Logic::Proposition::False.instance)
          end

          # A Restriction with a false predicate matches nothing
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            Veritas::Relation::Empty.new(operation.header)
          end

        end # class FalsePredicate

        # Optimize when the operand is a Restriction
        class RestrictionOperand < self

          # Test if the operand is a Restriction
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(operation.class)
          end

          # Flatten nested Restrictions into a single Restriction
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            operation.class.new(operand.operand, optimized_predicate).optimize
          end

        private

          # Join the operand and operation predicates and optimize them
          #
          # @return [Expression]
          #
          # @api private
          def optimized_predicate
            Veritas::Logic::Connective::Conjunction.new(operand.predicate, predicate).optimize
          end

        end # class RestrictionOperand

        # Optimize when the operand is a Set
        class SetOperand < self

          # Test if the operand is a Restriction
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Set)
          end

          # Wrap each operand in the Set in a Restriction
          #
          # @return [Set]
          #
          # @api private
          def optimize
            operand.class.new(wrap_left, wrap_right).optimize
          end

        private

          # Utility method to wrap the left operand in a Restriction
          #
          # @return [Restriction]
          #
          # @api private
          def wrap_left
            operation.class.new(operand.left, predicate).optimize
          end

          # Utility method to wrap the right operand in a Restriction
          #
          # @return [Restriction]
          #
          # @api private
          def wrap_right
            operation.class.new(operand.right, predicate).optimize
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

          # Wrap the Restriction in a Reverse
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

          # Wrap the Restriction in an Order
          #
          # @return [Order]
          #
          # @api private
          def optimize
            operand = self.operand
            operand.class.new(wrap_operand, operand.directions).optimize
          end

        end # class OrderOperand

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
            !predicate.equal?(operation.predicate)
          end

          # Return a Restriction with an optimized operand
          #
          # @return [Rename]
          #
          # @api private
          def optimize
            operation.class.new(operand, predicate).optimize
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Restriction.optimizer = chain(
          TruePredicate,
          FalsePredicate,
          RestrictionOperand,
          SetOperand,
          ReverseOperand,
          OrderOperand,
          EmptyOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Restriction
    end # module Algebra
  end # class Optimizer
end # module Veritas
