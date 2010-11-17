module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing LessThanOrEqualTo optimizations
        class LessThanOrEqualTo < self
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
              super || GreaterThan::AlwaysTrue.new(operation.inverse).optimizable?
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
              LessThan::AlwaysTrue.new(operation).optimizable? ||
              Equality::AlwaysTrue.new(operation).optimizable?
            end

          end # class AlwaysTrue

          Veritas::Logic::Predicate::LessThanOrEqualTo.optimizer = chain(
            ConstantOperands,
            AlwaysFalse,
            AlwaysTrue,
            NormalizableOperands
          )

        end # class LessThanOrEqualTo
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
