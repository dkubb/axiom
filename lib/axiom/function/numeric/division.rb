# encoding: utf-8

module Axiom
  class Function
    class Numeric

      # A class representing a division function
      class Division < Numeric
        include Comparable, Binary

        # Return the Division operation
        #
        # @example
        #   Division.operation  # => :/
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :/
        end

        # Return the inverse function class
        #
        # @example
        #   Division.inverse  # => Multiplication
        #
        # @return [Class<Multiplication>]
        #
        # @api public
        def self.inverse
          Multiplication
        end

        # Return the type returned from #call
        #
        # @example
        #   type = division.type
        #
        # @return [Class<Attribute::Float>]
        #
        # @api public
        def type
          Attribute::Float
        end

        module Methods
          extend Aliasable

          inheritable_alias(:/ => :divide)

          # Return a division function
          #
          # @example
          #   division = attribute.divide(other)
          #
          # @param [Object] other
          #
          # @return [Division]
          #
          # @api public
          def divide(other)
            Division.new(self, other)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }
        Numeric.class_eval            { include Methods }

      end # class Division
    end # class Numeric
  end # class Function
end # module Axiom
