# encoding: utf-8

module Axiom
  class Function
    class Numeric

      # A class representing a unary minus function
      class UnaryMinus < Numeric
        include Unary

        # Return the unary minus operation
        #
        # @example
        #   UnaryMinus.operation  # => :-@
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :-@
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
end # module Axiom
