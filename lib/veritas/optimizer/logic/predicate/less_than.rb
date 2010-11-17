module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing LessThan optimizations
        class LessThan < self
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
              LessThanOrEqualTo::AlwaysFalse.new(operation).optimizable?
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
              operation.class.call(Predicate::Util.max(left), Predicate::Util.min(right))
            end

          end # class AlwaysTrue

          Veritas::Logic::Predicate::LessThan.optimizer = chain(
            ConstantOperands,
            AlwaysFalse,
            AlwaysTrue,
            NormalizableOperands
          )

        end # class LessThan
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
