module Veritas
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

        # Return a string representing the length function
        #
        # @example
        #   length.inspect  # => 'LENGTH("a string")'
        #
        # @return [String]
        #
        # @api public
        def inspect
          "LENGTH(#{operand.inspect})"
        end

        module Methods
          extend Aliasable

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
end # module Veritas
