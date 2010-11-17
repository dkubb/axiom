module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing Inequality optimizations
        class Inequality < self
          include Comparable

          # Optimize when the operand are always false
          class AlwaysFalse < self
            include Predicate::AlwaysFalse

            # Test if the operands are always false
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.equal?(right)
            end

          end # class AlwaysFalse

          # Optimize when the operand are always true
          class AlwaysTrue < self
            include Comparable::NeverEquivalent
            include Predicate::AlwaysTrue
          end # class AlwaysTrue

          Veritas::Logic::Predicate::Inequality.optimizer = chain(
            ConstantOperands,
            AlwaysFalse,
            AlwaysTrue,
            NormalizableOperands
          )

        end # class Inequality
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
