module Veritas
  class Function
    class Predicate

      # A mixin for predicates matching an enumerable
      module Enumerable

        # Return the method to test the enumerable with
        #
        # @param [#cover?, #include?] enumerable
        #
        # @return [Symbol]
        #
        # @api private
        def self.compare_method(enumerable)
          enumerable.respond_to?(:cover?) ? :cover? : :include?
        end

        # Initialize an Enumerable predicate
        #
        # @param [Object] left
        #   the attribute or object to test for in the Enumerable
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
  end # class Function
end # module Veritas
