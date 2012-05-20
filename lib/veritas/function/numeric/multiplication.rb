# encoding: utf-8

module Veritas
  class Function
    class Numeric

      # A class representing a multiplication function
      class Multiplication < Numeric
        include Comparable, Binary

        # Return the Multiplication operation
        #
        # @example
        #   Multiplication.operation  # => :*
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :*
        end

        # Return the inverse function class
        #
        # @example
        #   Multiplication.inverse  # => Division
        #
        # @return [Class<Division>]
        #
        # @api public
        def self.inverse
          Division
        end

        module Methods
          extend Aliasable

          inheritable_alias(:* => :multiply)

          # Return a multiplication function
          #
          # @example
          #   multiplication = attribute.multiply(other)
          #
          # @param [Object] other
          #
          # @return [Multiplication]
          #
          # @api public
          def multiply(other)
            Multiplication.new(self, other)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }
        Numeric.class_eval            { include Methods }

      end # class Multiplication
    end # class Numeric
  end # class Function
end # module Veritas
