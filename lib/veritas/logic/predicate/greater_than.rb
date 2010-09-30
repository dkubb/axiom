module Veritas
  module Logic
    class Predicate

      # A predicate representing a greater than test between operands
      class GreaterThan < Predicate
        include Comparable

        # Return the GreaterThan operation
        #
        # @example
        #   GreaterThan.operation  # => :>
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :>
        end

        # Return the inverse predicate class
        #
        # @example
        #   GreaterThan.inverse  # => LessThanOrEqualTo
        #
        # @return [Class<LessThanOrEqualTo>]
        #
        # @api public
        def self.inverse
          LessThanOrEqualTo
        end

        # Return the reverse predicate class
        #
        # @example
        #   GreaterThan.reverse  # => LessThan
        #
        # @return [Class<LessThan>]
        #
        # @api public
        def self.reverse
          LessThan
        end

        module Methods

          # Compare the left to see if it is greater than the right
          #
          # @example
          #   greater_than = expression.gt(other)
          #
          # @param [Expression] other
          #
          # @return [GreaterThan]
          #
          # @api public
          def gt(other)
            GreaterThan.new(self, other)
          end

        end # module Methods
      end # class GreaterThan
    end # class Predicate
  end # module Logic
end # module Veritas
