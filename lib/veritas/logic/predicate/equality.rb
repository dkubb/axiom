module Veritas
  module Logic
    class Predicate

      # A predicate representing an equality test between operands
      class Equality < Predicate
        include Comparable

        # Return the Equality operation
        #
        # @example
        #   Equality.operation  # => :==
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :==
        end

        # Return the inverse predicate class
        #
        # @example
        #   Equality.inverse  # => Inequality
        #
        # @return [Inequality]
        #
        # @api public
        def self.inverse
          Inequality
        end

        # Return the reverse predicate class
        #
        # @example
        #   Equality.reverse  # => Equality
        #
        # @return [self]
        #
        # @api public
        def self.reverse
          self
        end

        module Methods

          # Compare the expressions for Equality
          #
          # @example
          #   equality = expression.eq(other)
          #
          # @param [Expression] other
          #
          # @return [Equality]
          #
          # @api public
          def eq(other)
            Equality.new(self, other)
          end

        end # module Methods
      end # class Equality
    end # class Predicate
  end # module Logic
end # module Veritas
