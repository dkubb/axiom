# encoding: utf-8

module Veritas
  class Function
    class Numeric

      # A class representing a unary minus function
      class UnaryMinus < Numeric
        include Unary

        # Return the value subtracted from 0
        #
        # @example
        #   negated_value = UnaryMinus.call(value)
        #
        # @param [Numeric] value
        #
        # @return [Numeric]
        #
        # @api public
        def self.call(value)
          -value
        end

        # Return the inverse function class
        #
        # @example
        #   UnaryMinus.inverse  # => UnaryPlus
        #
        # @return [Class<UnaryPlus>]
        #
        # @api public
        def self.inverse
          UnaryPlus
        end

        # Return a string representing the unary minus function
        #
        # @example
        #   unary_minus.inspect  # => "-1"
        #
        # @return [String]
        #
        # @api public
        def inspect
          "-(#{operand.inspect})"
        end

        module Methods
          extend Aliasable

          inheritable_alias(:-@ => :unary_minus)

          # Return a unary minus function
          #
          # @example
          #   unary_minus = attribute.unary_minus
          #
          # @return [UnaryMinus]
          #
          # @api public
          def unary_minus
            UnaryMinus.new(self)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }
        Numeric.class_eval            { include Methods }

      end # class UnaryMinus
    end # class Numeric
  end # class Function
end # module Veritas
