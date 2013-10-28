# encoding: utf-8

module Axiom
  class Function
    class Predicate

      # A predicate representing an inclusion test
      class Inclusion < Predicate
        include Enumerable

        # Test an enumerable to see if a value is included
        #
        # @example
        #   Inclusion.call(1, [1, 2, 3])  # => true
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
          right.public_send(Enumerable.compare_method(right), left)
        end

        # Return the inverse predicate class
        #
        # @example
        #   Inclusion.inverse  # => Exclusion
        #
        # @return [Class<Exclusion>]
        #
        # @api public
        def self.inverse
          Exclusion
        end

        module Methods

          # Compare the left to see if it is included in the right
          #
          # @example
          #   inclusion = attribute.include([1, 2, 3])
          #
          # @param [Function] other
          #
          # @return [Inclusion]
          #
          # @api public
          def include(other)
            Inclusion.new(self, other)
          end

        end # module Methods
      end # class Inclusion
    end # class Predicate
  end # class Function
end # module Axiom
