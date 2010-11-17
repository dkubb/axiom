module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing Match optimizations
        class Match < self

          Veritas::Logic::Predicate::Match.optimizer = chain(
            ConstantOperands
          )

        end # class Match
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
