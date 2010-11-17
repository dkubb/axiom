module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing NoMatch optimizations
        class NoMatch < self

          Veritas::Logic::Predicate::NoMatch.optimizer = chain(
            ConstantOperands
          )

        end # class NoMatch
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
