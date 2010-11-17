module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing Equality optimizations
        class Equality < self
          include Comparable

          # Optimize when the operand are always false
          class AlwaysFalse < self
            include Comparable::NeverEquivalent
            include Predicate::AlwaysFalse
          end # class AlwaysFalse

          # Optimize when the operand are always true
          class AlwaysTrue < self
            include Predicate::AlwaysTrue

            # Test if the operands are always true
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.equal?(right)
            end

          end # class AlwaysTrue

          Veritas::Logic::Predicate::Equality.optimizer = chain(
            ConstantOperands,
            AlwaysFalse,
            AlwaysTrue,
            NormalizableOperands
          )

        end # class Equality
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
