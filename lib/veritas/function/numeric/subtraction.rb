# encoding: utf-8

module Veritas
  class Function
    class Numeric

      # A class representing a subtraction function
      class Subtraction < Numeric
        include Comparable, Binary

        # Return the Subtraction operation
        #
        # @example
        #   Subtraction.operation  # => :-
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :-
        end

        # Return the inverse function class
        #
        # @example
        #   Subtraction.inverse  # => Addition
        #
        # @return [Class<Addition>]
        #
        # @api public
        def self.inverse
          Addition
        end

        module Methods
          extend Aliasable

          inheritable_alias(:- => :subtract)

          # Return a subtraction function
          #
          # @example
          #   subtraction = attribute.subtract(other)
          #
          # @param [Object] other
          #
          # @return [Subtraction]
          #
          # @api public
          def subtract(other)
            Subtraction.new(self, other)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }
        Numeric.class_eval            { include Methods }

      end # class Subtraction
    end # class Numeric
  end # class Function
end # module Veritas
