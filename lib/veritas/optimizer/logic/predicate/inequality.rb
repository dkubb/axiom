module Veritas
  class Optimizer
    module Logic
      class Predicate
        class Inequality < self
          include Comparable

          class AlwaysFalse < self
            include Predicate::AlwaysFalse

            def optimizable?
              left.equal?(right)
            end

          end # class AlwaysFalse

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
