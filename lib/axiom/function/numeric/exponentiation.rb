# encoding: utf-8

module Axiom
  class Function
    class Numeric

      # A class representing a exponentiation function
      class Exponentiation < Numeric
        include Comparable, Binary::Invertible, Binary

        undef_method :inverse

        # Return the Exponentiation operation
        #
        # @example
        #   Exponentiation.operation  # => :**
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :**
        end

        # Return the inverse function
        #
        # @example
        #   inverse = exponentiation.inverse
        #
        # @return [Exponentiation]
        #
        # @api public
        def inverse
          self.class.new(left, Division.new(1, right)).memoize(:inverse, self)
        end

        module Methods
          extend Aliasable

          inheritable_alias(
            :**  => :exponent,
            :pow => :exponent
          )

          # Return an exponential function
          #
          # @example
          #   exponentiation = attribute.exponent(other)
          #
          # @param [Object] other
          #
          # @return [Exponentiation]
          #
          # @api public
          def exponent(other)
            Exponentiation.new(self, other)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }
        Numeric.class_eval            { include Methods }

        memoize :inverse

      end # class Exponentiation
    end # class Numeric
  end # class Function
end # module Axiom
