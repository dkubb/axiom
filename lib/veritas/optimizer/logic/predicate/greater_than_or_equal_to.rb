module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing GreaterThanOrEqualTo optimizations
        class GreaterThanOrEqualTo < self
          include Comparable

          # Optimize when the operands are always false
          class AlwaysFalse < self
            include Comparable::NeverComparable
            include Predicate::AlwaysFalse

            # Test if the operands are always false
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              super || LessThan::AlwaysTrue.new(operation.inverse).optimizable?
            end

          end # class AlwaysFalse

          # Optimize when the operands are always true
          class AlwaysTrue < self
            include Predicate::AlwaysTrue

            # Test if the operands are always true
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operation = self.operation
              GreaterThan::AlwaysTrue.new(operation).optimizable? ||
              Equality::AlwaysTrue.new(operation).optimizable?
            end

          end # class AlwaysTrue

          Veritas::Logic::Predicate::GreaterThanOrEqualTo.optimizer = chain(
            ConstantOperands,
            AlwaysFalse,
            AlwaysTrue,
            NormalizableOperands
          )

        end # class GreaterThanOrEqualTo
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
