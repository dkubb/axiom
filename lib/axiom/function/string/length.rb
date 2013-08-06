# encoding: utf-8

module Axiom
  class Function
    module String

      # A class representing a length function
      class Length < Function
        include Unary

        # Return the string length
        #
        # @example
        #   length = Length.call(value)
        #
        # @param [String] value
        #
        # @return [Integer]
        #
        # @api public
        def self.call(value)
          value.length
        end

        # Return the type returned from #call
        #
        # @example
        #   type = Axiom::Function::String.type  # => Axiom::Types::Integer
        #
        # @return [Class<Types::Integer>]
        #
        # @api public
        def self.type
          Types::Integer
        end

        module Methods

          # Return a length function
          #
          # @example
          #   length = attribute.length
          #
          # @return [Length]
          #
          # @api public
          def length
            Length.new(self)
          end

        end # module Methods

        Attribute::String.class_eval { include Methods }

      end # class Length
    end # module String
  end # class Function
end # module Axiom
