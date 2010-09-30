module Veritas
  module Logic
    class Predicate

      # A predicate representing a greater than or equal to test between operands
      class GreaterThanOrEqualTo < Predicate
        include Comparable

        # Return the GreaterThanOrEqualTo operation
        #
        # @example
        #   GreaterThanOrEqualTo.operation  # => :>=
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :>=
        end

        # Return the inverse predicate class
        #
        # @example
        #   GreaterThanOrEqualTo.inverse  # => LessThan
        #
        # @return [Class<LessThan>]
        #
        # @api public
        def self.inverse
          LessThan
        end

        # Return the reverse predicate class
        #
        # @example
        #   GreaterThanOrEqualTo.reverse  # => LessThanOrEqualTo
        #
        # @return [Class<LessThanOrEqualTo>]
        #
        # @api public
        def self.reverse
          LessThanOrEqualTo
        end

        module Methods

          # Compare the left to see if it is greater than or equal to the right
          #
          # @example
          #   greater_than_or_equal_to = expression.gte(other)
          #
          # @param [Expression] other
          #
          # @return [GreaterThanOrEqualTo]
          #
          # @api public
          def gte(other)
            GreaterThanOrEqualTo.new(self, other)
          end

        end # module Methods
      end # class GreaterThanOrEqualTo
    end # class Predicate
  end # module Logic
end # module Veritas
