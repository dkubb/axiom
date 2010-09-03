module Veritas
  class Optimizer
    module Logic
      class Predicate
        class Match < self

          Veritas::Logic::Predicate::Match.optimizer = chain(
            ConstantOperands
          )

        end # class Match
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
