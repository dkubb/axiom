# encoding: utf-8

module Veritas
  class Function
    class Numeric

      # A class representing a unary plus function
      class UnaryPlus < Numeric
        include Unary

        # Return the value added to 0
        #
        # This is a noop.
        #
        # @example
        #   new_value = UnaryPlus.call(value)
        #
        # @param [Numeric] value
        #
        # @return [Numeric]
        #
        # @api public
        def self.call(value)
          +value
        end

        # Return the inverse function class
        #
        # @example
        #   UnaryPlus.inverse  # => UnaryMinus
        #
        # @return [Class<UnaryMinus>]
        #
        # @api public
        def self.inverse
          UnaryMinus
        end

        # Return a string representing the unary plus function
        #
        # @example
        #   unary_plus.inspect  # => "+1"
        #
        # @return [String]
        #
        # @api public
        def inspect
          "+(#{operand.inspect})"
        end

        module Methods
          extend Aliasable

          inheritable_alias(:+@ => :unary_plus)

          # Return a unary plus function
          #
          # @example
          #   unary_plus = attribute.unary_plus
          #
          # @return [UnaryPlus]
          #
          # @api public
          def unary_plus
            UnaryPlus.new(self)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }

      end # class UnaryPlus
    end # class Numeric
  end # class Function
end # module Veritas
