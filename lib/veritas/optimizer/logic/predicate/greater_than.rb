module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing GreaterThan optimizations
        class GreaterThan < self
          include Comparable

          # Optimize when the operands are always false
          class AlwaysFalse < self
            include Predicate::AlwaysFalse

            # Test if the operands are always false
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.equal?(right) ||
              GreaterThanOrEqualTo::AlwaysFalse.new(operation).optimizable?
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
              operation.class.call(Predicate::Util.min(left), Predicate::Util.max(right))
            end

          end # class AlwaysTrue

          Veritas::Logic::Predicate::GreaterThan.optimizer = chain(
            ConstantOperands,
            AlwaysFalse,
            AlwaysTrue,
            NormalizableOperands
          )

        end # class GreaterThan
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
