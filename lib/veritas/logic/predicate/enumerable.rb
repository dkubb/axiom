module Veritas
  module Logic
    class Predicate

      # A mixin for predicates matching an enumerable
      module Enumerable

        # Initialize an Enumerable predicate
        #
        # @param [Object] left
        #   the attribute or value to test for in the Enumerable
        # @param [Enumerable] right
        #   the enumerable to test
        #
        # @return [undefined]
        #
        # @api private
        def initialize(left, right)
          super(left, Immutable.freeze_object(right))
        end

      end # module Enumerable
    end # class Predicate
  end # module Logic
end # module Veritas
