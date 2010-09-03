module Veritas
  class Optimizer
    module Logic
      class Predicate
        class GreaterThan < self
          include Comparable

          class AlwaysFalse < self
            include Predicate::AlwaysFalse

            def optimizable?
              left.equal?(right) ||
              GreaterThanOrEqualTo::AlwaysFalse.new(operation).optimizable?
            end

          end # class AlwaysFalse

          class AlwaysTrue < self
            include Predicate::AlwaysTrue

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
