module Veritas
  class Optimizer
    module Logic
      class Predicate
        class Equality < self
          include Comparable

          class AlwaysFalse < self
            include Comparable::NeverEquivalent
            include Predicate::AlwaysFalse
          end # class AlwaysFalse

          class AlwaysTrue < self
            include Predicate::AlwaysTrue

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
