# encoding: utf-8

module Axiom
  class Function
    class Numeric

      # A class representing a square root function
      class SquareRoot < Numeric
        include Unary::Invertible, Unary

        undef_method :inverse

        # Return the square root of the value
        #
        # @example
        #   square_root = SquareRoot.call(value)
        #
        # @param [Numeric] value
        #
        # @return [Numeric]
        #
        # @api public
        def self.call(value)
          Math.sqrt(value)
        end

        # Return the inverse function
        #
        # @example
        #   inverse = square_root.inverse
        #
        # @return [Exponentiation]
        #
        # @api public
        def inverse
          Exponentiation.new(operand, 2).memoize(:inverse, self)
        end

        # Return the type returned from #call
        #
        # @return [Class<Attribute::Float>]
        #
        # @api public
        def type
          Attribute::Float
        end

        module Methods
          extend Aliasable

          inheritable_alias(:sqrt => :square_root)

          # Return a square root function
          #
          # @example
          #   square_root = attribute.square_root
          #
          # @return [SquareRoot]
          #
          # @api public
          def square_root
            SquareRoot.new(self)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }
        Numeric.class_eval            { include Methods }

        memoize :inverse

      end # class SquareRoot
    end # class Numeric
  end # class Function
end # module Axiom
