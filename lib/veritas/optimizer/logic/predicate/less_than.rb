module Veritas
  class Optimizer
    module Logic
      class Predicate
        class LessThan < self
          include Comparable

          class AlwaysFalse < self
            include Predicate::AlwaysFalse

            def optimizable?
              left.equal?(right) ||
              LessThanOrEqualTo::AlwaysFalse.new(operation).optimizable?
            end

          end # class AlwaysFalse

          class AlwaysTrue < self
            include Predicate::AlwaysTrue

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
