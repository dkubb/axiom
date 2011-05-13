# encoding: utf-8

module Veritas
  class Function
    class Predicate

      # A predicate representing a less than or equal to test between operands
      class LessThanOrEqualTo < Predicate
        include Comparable

        # Return the LessThanOrEqualTo operation
        #
        # @example
        #   LessThanOrEqualTo.operation  # => :<=
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :<=
        end

        # Return the inverse predicate class
        #
        # @example
        #   LessThanOrEqualTo.inverse  # => GreaterThan
        #
        # @return [Class<GreaterThan>]
        #
        # @api public
        def self.inverse
          GreaterThan
        end

        # Return the reverse predicate class
        #
        # @example
        #   LessThanOrEqualTo.reverse  # => GreaterThanOrEqualTo
        #
        # @return [Class<GreaterThanOrEqualTo>]
        #
        # @api public
        def self.reverse
          GreaterThanOrEqualTo
        end

        module Methods

          # Compare the left to see if it is less than or equal to the right
          #
          # @example
          #   less_than_or_equal_to = expression.lte(other)
          #
          # @param [Function] other
          #
          # @return [LessThanOrEqualTo]
          #
          # @api public
          def lte(other)
            LessThanOrEqualTo.new(self, other)
          end

        end # module Methods
      end # class LessThanOrEqualTo
    end # class Predicate
  end # class Function
end # module Veritas
