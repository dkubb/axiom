# encoding: utf-8

module Axiom
  class Function
    class Numeric

      # A class representing a unary plus function
      class UnaryPlus < Numeric
        include Unary

        # Return the unary plus operation
        #
        # @example
        #   UnaryPlus.operation  # => :+@
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :+@
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
        Numeric.class_eval            { include Methods }

      end # class UnaryPlus
    end # class Numeric
  end # class Function
end # module Axiom
