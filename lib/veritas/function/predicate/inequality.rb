module Veritas
  class Function
    class Predicate

      # A predicate representing an inequality test between operands
      class Inequality < Predicate
        include Comparable

        # Return the Inequality operation
        #
        # @example
        #   Inequality.operation  # => :!=
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :'!='
        end

        # Return the inverse predicate class
        #
        # @example
        #   Inequality.inverse  # => Equality
        #
        # @return [Class<Equality>]
        #
        # @api public
        def self.inverse
          Equality
        end

        # Return the reverse predicate class
        #
        # @example
        #   Inequality.reverse  # => Inequality
        #
        # @return [self]
        #
        # @api public
        def self.reverse
          self
        end

        # Evaluate the values for inequality
        #
        # @example
        #   Inequality.call(left, right)  # => true or false
        #
        # @param [Object] left
        # @param [Object] right
        #
        # @return [Boolean]
        #
        # @api public
        def self.call(left, right)
          left != right
        end unless Object.method_defined?(operation)

        module Methods

          # Compare the left to see if it is not equal to the right
          #
          # @example
          #   inequality = expression.ne(other)
          #
          # @param [Function] other
          #
          # @return [Inequality]
          #
          # @api public
          def ne(other)
            Inequality.new(self, other)
          end

        end # module Methods
      end # class Inequality
    end # class Predicate
  end # module Algebra
end # module Veritas
