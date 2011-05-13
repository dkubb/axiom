# encoding: utf-8

module Veritas
  class Function
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
        # @return [Class<Inequality>]
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

          # Compare the left to see if it is equal to the right
          #
          # @example
          #   equality = expression.eq(other)
          #
          # @param [Function] other
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
  end # class Function
end # module Veritas
