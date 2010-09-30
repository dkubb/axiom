# encoding: utf-8

module Veritas
  module Logic
    class Predicate

      # A predicate representing an exclusion test
      class Exclusion < Predicate
        include Enumerable

        # Test an enumerable to see if a value is excluded
        #
        # @example
        #   Exclusion.call(1, [ 1, 2, 3 ])  # => true
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
          !right.include?(left)
        end

        # Return the inverse predicate class
        #
        # @example
        #   Exclusion.inverse  # => Inclusion
        #
        # @return [Inclusion]
        #
        # @api public
        def self.inverse
          Inclusion
        end

        # Return a string representing the predicate
        #
        # @example
        #   exclusion.inspect  # "<Attribute::Integer name: id> ∉ [1, 2, 3]"
        #
        # @return [String]
        #
        # @api public
        def inspect
          "#{left.inspect} ∉ #{right.inspect}"
        end

        module Methods

          # Compare whether the Attribute is excluded from the Enumerable
          #
          # @example
          #   equality = attribute.exclude([ 1, 2, 3 ])
          #
          # @param [Expression] other
          #
          # @return [Equality]
          #
          # @api public
          def exclude(other)
            Exclusion.new(self, other)
          end

        end # module Methods
      end # class Exclusion
    end # class Predicate
  end # module Logic
end # module Veritas
