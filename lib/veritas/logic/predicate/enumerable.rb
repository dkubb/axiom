module Veritas
  module Logic
    class Predicate
      module Enumerable

        def initialize(left, right)
          super(left, Immutable.freeze_value(right))
        end

      end # module Enumerable
    end # class Predicate
  end # module Logic
end # module Veritas
