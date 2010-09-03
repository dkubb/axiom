module Veritas
  class Optimizer
    module Algebra
      class Restriction < Relation::Operation::Unary
        attr_reader :predicate

        def initialize(*)
          super
          @predicate = self.class.optimize_predicate(operation.predicate)
        end

      private

        def wrap_operand
          operation.class.new(operand.operand, predicate)
        end

        def self.optimize_predicate(predicate)
          predicate.respond_to?(:optimize) ? predicate.optimize : predicate
        end

        class TruePredicate < self
          def optimizable?
            predicate.equal?(Veritas::Logic::Proposition::True.instance)
          end

          def optimize
            operand
          end

        end # class TruePredicate

        class FalsePredicate < self
          def optimizable?
            predicate.equal?(Veritas::Logic::Proposition::False.instance)
          end

          def optimize
            Veritas::Relation::Empty.new(operation.header)
          end

        end # class FalsePredicate

        class RestrictionOperand < self
          def optimizable?
            operand.kind_of?(operation.class)
          end

          def optimize
            operation.class.new(operand.operand, optimized_predicate)
          end

        private

          def optimized_predicate
            Veritas::Logic::Connective::Conjunction.new(operand.predicate, predicate).optimize
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
            operation.class.new(operand.left, predicate)
          end

          def wrap_right
            operation.class.new(operand.right, predicate)
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
            operand = self.operand
            operand.class.new(wrap_operand, operand.directions).optimize
          end

        end # class OrderOperand

        class UnoptimizedOperand < self
          def optimizable?
            operation = self.operation
            !operand.equal?(operation.operand) ||
            !predicate.equal?(operation.predicate)
          end

          def optimize
            operation.class.new(operand, predicate)
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
