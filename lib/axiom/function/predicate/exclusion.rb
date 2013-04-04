# encoding: utf-8

module Axiom
  class Function
    class Predicate

      # A predicate representing an exclusion test
      class Exclusion < Predicate
        include Enumerable

        # Test an enumerable to see if a value is excluded
        #
        # @example
        #   Exclusion.call(1, [ 1, 2, 3 ])  # => false
        #
        # @param [Object] left
        #   the object to test for in the Enumerable
        # @param [Enumerable] right
        #   the enumerable to test
        #
        # @return [Boolean]
        #
        # @api public
        def self.call(left, right)
          ! right.send(Enumerable.compare_method(right), left)
        end

        # Return the inverse predicate class
        #
        # @example
        #   Exclusion.inverse  # => Inclusion
        #
        # @return [Class<Inclusion>]
        #
        # @api public
        def self.inverse
          Inclusion
        end

        module Methods

          # Compare the left to see if it is excluded from the right
          #
          # @example
          #   exclusion = attribute.exclude([ 1, 2, 3 ])
          #
          # @param [Function] other
          #
          # @return [Exclusion]
          #
          # @api public
          def exclude(other)
            Exclusion.new(self, other)
          end

        end # module Methods
      end # class Exclusion
    end # class Predicate
  end # class Function
end # module Axiom
