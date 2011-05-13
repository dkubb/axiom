# encoding: utf-8

module Veritas
  class Function
    class Predicate

      # A predicate representing a less than test between operands
      class LessThan < Predicate
        include Comparable

        # Return the LessThan operation
        #
        # @example
        #   LessThan.operation  # => :<
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :<
        end

        # Return the inverse predicate class
        #
        # @example
        #   LessThan.inverse  # => GreaterThanOrEqualTo
        #
        # @return [Class<GreaterThanOrEqualTo>]
        #
        # @api public
        def self.inverse
          GreaterThanOrEqualTo
        end

        # Return the reverse predicate class
        #
        # @example
        #   LessThan.reverse  # => GreaterThan
        #
        # @return [Class<GreaterThan>]
        #
        # @api public
        def self.reverse
          GreaterThan
        end

        module Methods

          # Compare the left to see if it is less than the right
          #
          # @example
          #   less_than = expression.lt(other)
          #
          # @param [Function] other
          #
          # @return [LessThan]
          #
          # @api public
          def lt(other)
            LessThan.new(self, other)
          end

        end # module Methods
      end # class LessThan
    end # class Predicate
  end # class Function
end # module Veritas
